program PHiveMapExport;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  Windows,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  StrUtils,
  Math,
  FileFunc in 'FileFunc.pas',
  ExplodeFunc in 'ExplodeFunc.pas';

var
  i, j, tilecount, spritecount, piececount, palused: integer;
  outfolder, inipath, s, mapasm, dplcasm, gfxasm, gfxline, gfxfilename,
  mapindexhead, mapindexfoot, mapindexline, maphead, mapfoot, mapline,
  dplcindexhead, dplcindexfoot, dplcindexline, dplchead, dplcfoot, dplcline, dplcmode,
  histr, lowstr, palfilename, palsize: string;
  inifile, mapasmfile, dplcasmfile, gfxasmfile: textfile;
  currfile: ^textfile;
  PNG: TPNGImage;
  palarray: array[0..63] of TColor;
  spritenames: array of string;
  spritetable, piecetable, spritetiles, spritepieces, pieceglobal, piecelocal: array of integer;
  palstr: array[0..3] of string;
  splitgfxfile: boolean;

const
  piecewidth: array[0..15] of integer = (8,8,8,8,16,16,16,16,24,24,24,24,32,32,32,32);
  pieceheight: array[0..15] of integer = (8,16,24,32,8,16,24,32,8,16,24,32,8,16,24,32);
  piecesize: array[0..15] of integer = (1,2,3,4,2,4,6,8,3,6,9,12,4,8,12,16);

{ Convert RGB hex string to TColor. }

function StrToTColor(str: string): TColor;
var c: integer;
begin
  if str = '' then c := 0
    else c := StrToInt('$'+str);
  result := RGB(c shr 16, (c shr 8) and $FF, c and $FF);
end;

{ Find out if piece is inside sprite. }

function PieceInSprite(p, s: integer): boolean;
var x, y, w, h: integer;
begin
  result := false; // Assume piece isn't in sprite.
  x := spritetable[s*4]-spritetable[(s*4)+2]; // Get position of sprite.
  y := spritetable[(s*4)+1]-spritetable[(s*4)+3];
  w := spritetable[(s*4)+2]*2; // Get width/height of sprite.
  h := spritetable[(s*4)+3]*2;
  if piecetable[p*4] < x then exit; // Piece is left of sprite.
  if piecetable[(p*4)+1] < y then exit; // Piece is above sprite.
  if piecetable[p*4]+piecewidth[piecetable[(p*4)+3]] >= x+w then exit; // Piece is right of sprite.
  if piecetable[(p*4)+1]+pieceheight[piecetable[(p*4)+3]] >= y+h then exit; // Piece is below sprite.
  result := true; // Piece is inside sprite.
end;

{ Find pixel colour value in palette. }

function GetPalIndex(c: TColor; p: integer): byte;
var i: integer;
begin
  result := 0; // Assume transparent.
  for i := 0 to 15 do
    if c = palarray[(p*16)+i] then
      begin
      result := i; // Use matching colour instead.
      exit;
      end;
end;

{ Write a piece to the output file. }

procedure WritePiece(x, y, p, s: integer);
var i, j, k: integer;
  pix: TColor;
  pixrow: longword;
begin
  for i := 0 to (piecewidth[s] div 8)-1 do
    for j := 0 to pieceheight[s]-1 do
      begin
      pixrow := 0;
      for k := 0 to 7 do
        begin
        pix := PNG.Pixels[x+(i*8)+k,y+j]; // Read pixel from PNG.
        pixrow := (pixrow shl 4)+GetPalIndex(pix,p); // Create longword containing 8 pixels.
        end;
      WriteDword(fs,pixrow); // Append longword to file.
      end;
end;

{ Write line to asm file. }

procedure WriteASM(var myfile: textfile; s: string);
begin
  s := ReplaceStr(s,'{n}',#13#10); // Insert linebreaks.
  WriteLn(myfile,s);
end;

{ Format mappings line. }

function FormatMapLine(str: string; spr, pie: integer): string;
begin
  result := ReplaceStr(str,'{xpos}',IntToStr(piecetable[pie*4]-spritetable[spr*4]));
  result := ReplaceStr(result,'{ypos}',IntToStr(piecetable[(pie*4)+1]-spritetable[(spr*4)+1]));
  result := ReplaceStr(result,'{size}',IntToStr(piecetable[(pie*4)+3]));
  result := ReplaceStr(result,'{width}',IntToStr(piecewidth[piecetable[(pie*4)+3]] div 8));
  result := ReplaceStr(result,'{height}',IntToStr(pieceheight[piecetable[(pie*4)+3]] div 8));
  result := ReplaceStr(result,'{offsetlocal}',IntToStr(piecelocal[pie])); // Gfx offset within sprite.
  result := ReplaceStr(result,'{offsetglobal}',IntToStr(pieceglobal[pie])); // Gfx offset within all gfx.
  result := ReplaceStr(result,'{pal}',palstr[piecetable[(pie*4)+2] and 3]);
  if piecetable[(pie*4)+2] and $10 <> 0 then result := ReplaceStr(result,'{priority}',histr)
  else result := ReplaceStr(result,'{priority}',lowstr);
end;

{ Format DPLC line. }

function FormatDPLCLine(str: string; spr, pie: integer): string;
begin
  result := ReplaceStr(str,'{name}',spritenames[spr]); // Sprite name.
  result := ReplaceStr(result,'{size}',IntToStr(piecesize[piecetable[(pie*4)+3]])); // Tiles in piece.
  result := ReplaceStr(result,'{size0}',IntToStr(piecesize[piecetable[(pie*4)+3]]-1)); // Tiles in piece (0=1).
  result := ReplaceStr(result,'{tilecount}',IntToStr(spritetiles[spr])); // Tiles in sprite.
  result := ReplaceStr(result,'{bytecount}',IntToStr(spritetiles[spr]*32)); // Bytes in sprite.
  result := ReplaceStr(result,'{offsetlocal}',IntToStr(piecelocal[pie])); // Gfx offset within sprite.
  result := ReplaceStr(result,'{offsetglobal}',IntToStr(pieceglobal[pie])); // Gfx offset within all gfx.
end;

{ Format header. }

function FormatHeader(str: string; spr: integer): string;
begin
  result := ReplaceStr(str,'{name}',spritenames[spr]); // Sprite name.
  result := ReplaceStr(result,'{piececount}',IntToStr(spritepieces[spr])); // Pieces in sprite.
  result := ReplaceStr(result,'{tilecount}',IntToStr(spritetiles[spr])); // Tiles in sprite.
  result := ReplaceStr(result,'{bytecount}',IntToStr(spritetiles[spr]*32)); // Bytes in sprite.
end;

{ Format footer. }

function FormatFooter(str: string; spr: integer): string;
begin
  result := FormatHeader(str,spr);
end;

{ Format index. }

function FormatIndex(str: string; spr: integer): string;
begin
  result := ReplaceStr(str,'{name}',spritenames[spr]); // Sprite name.
end;

{ Convert TColor to Mega Drive colour. }

function TColorToMD(col: TColor): word;
var r, g, b: byte;
begin
  r := col and $FF;
  g := (col shr 8) and $FF;
  b := col shr 16;
  result := ((r and $E0) shr 4)+(g and $E0)+((b and $E0) shl 4);
end;

{ Check line for setting in INI file. }

function CheckINIAny(s, line: string): boolean;
begin
  if AnsiPos(s+'=',line) = 1 then
    result := true // Setting was found.
  else result := false;
end;

function CheckINI(s, line: string): boolean;
begin
  if (AnsiPos(s+'=',line) = 1) and (Explode(line,s+'=',1) <> '') then
    result := true // Setting was found and wasn't blank.
  else result := false;
end;

begin

  { Program start }

  if ParamCount < 1 then // Check if program was run with parameters.
    begin
    WriteLn('Usage: HiveMapExport inifile outfolder');
    exit;
    end;
  if not FileExists(ParamStr(1)) then // Check if ini file exists.
    begin
    WriteLn('INI file not found.');
    exit;
    end;
  inipath := ExtractFilePath(ParamStr(1));
  outfolder := ParamStr(2);
  if outfolder = '' then outfolder := inipath // Use folder of ini file.
  else
    begin
    if not DirectoryExists(outfolder) then CreateDir(outfolder); // Create output folder if needed.
    outfolder := outfolder+'\'; // Append backslash.
    end;
  WriteLn('INI file: '+ParamStr(1));
  WriteLn('Output folder: '+outfolder);

  { Open ini and extract data. }

  spritecount := 0;
  piececount := 0;
  palused := 0;
  splitgfxfile := false;
  AssignFile(inifile,ParamStr(1)); // Open ini file.
  Reset(inifile);
  PNG := TPNGImage.Create; // Initialise PNG.
  while not eof(inifile) do
    begin
    ReadLn(inifile,s);
    if CheckINI('image',s) then
      try
      WriteLn('Image file: '+inipath+Explode(s,'image=',1));
      PNG.LoadFromFile(inipath+Explode(s,'image=',1)); // Load PNG.
      except
      WriteLn('Failed to load image.');
      exit;
      end
    else if CheckINI('palette',s) then
      begin
      s := Explode(s,'palette=',1);
      for i := 0 to 63 do
        begin
        if Explode(s,',',i) = '' then break; // Stop at end of palette.
        palarray[i] := StrToTColor(Explode(s,',',i)); // Write palette.
        Inc(palused); // Count number of colours.
        end;
      end
    else if CheckINI('sprite',s) then
      begin
      s := Explode(s,'sprite=',1);
      SetLength(spritenames,Length(spritenames)+1); // Add sprite.
      SetLength(spritetable,Length(spritetable)+4);
      spritenames[spritecount] := Explode(s,',',0); // Sprite name.
      spritetable[spritecount*4] := StrToInt(Explode(s,',',1)); // Sprite x pos.
      spritetable[(spritecount*4)+1] := StrToInt(Explode(s,',',2)); // Sprite y pos.
      spritetable[(spritecount*4)+2] := StrToInt(Explode(s,',',3)); // Sprite width.
      spritetable[(spritecount*4)+3] := StrToInt(Explode(s,',',4)); // Sprite height.
      Inc(spritecount);
      end
    else if CheckINI('piece',s) then
      begin
      s := Explode(s,'piece=',1);
      SetLength(piecetable,Length(piecetable)+4); // Add piece.
      piecetable[piececount*4] := StrToInt(Explode(s,',',0)); // Piece x pos.
      piecetable[(piececount*4)+1] := StrToInt(Explode(s,',',1)); // Piece y pos.
      piecetable[(piececount*4)+2] := StrToInt(Explode(s,',',2)); // Piece palette.
      piecetable[(piececount*4)+3] := StrToInt(Explode(s,',',3)); // Piece size.
      Inc(piececount);
      end
    else if CheckINI('mapasmfile',s) then mapasm := outfolder+Explode(s,'mapasmfile=',1)
    else if CheckINI('dplcasmfile',s) then dplcasm := outfolder+Explode(s,'dplcasmfile=',1)
    else if CheckINI('gfxasmfile',s) then gfxasm := outfolder+Explode(s,'gfxasmfile=',1)
    else if CheckINI('gfxfile',s) then gfxfilename := Explode(s,'gfxfile=',1)
    else if CheckINIAny('gfxline',s) then gfxline := Explode(s,'gfxline=',1)
    else if CheckINIAny('mapindexhead',s) then mapindexhead := Explode(s,'mapindexhead=',1)
    else if CheckINIAny('mapindexfoot',s) then mapindexfoot := Explode(s,'mapindexfoot=',1)
    else if CheckINIAny('mapindexline',s) then mapindexline := Explode(s,'mapindexline=',1)
    else if CheckINIAny('maphead',s) then maphead := Explode(s,'maphead=',1)
    else if CheckINIAny('mapfoot',s) then mapfoot := Explode(s,'mapfoot=',1)
    else if CheckINIAny('mapline',s) then mapline := Explode(s,'mapline=',1)
    else if CheckINIAny('pal1str',s) then palstr[0] := Explode(s,'pal1str=',1)
    else if CheckINIAny('pal2str',s) then palstr[1] := Explode(s,'pal2str=',1)
    else if CheckINIAny('pal3str',s) then palstr[2] := Explode(s,'pal3str=',1)
    else if CheckINIAny('pal4str',s) then palstr[3] := Explode(s,'pal4str=',1)
    else if CheckINIAny('histr',s) then histr := Explode(s,'histr=',1)
    else if CheckINIAny('lowstr',s) then lowstr := Explode(s,'lowstr=',1)
    else if CheckINIAny('dplcindexhead',s) then dplcindexhead := Explode(s,'dplcindexhead=',1)
    else if CheckINIAny('dplcindexfoot',s) then dplcindexfoot := Explode(s,'dplcindexfoot=',1)
    else if CheckINIAny('dplcindexline',s) then dplcindexline := Explode(s,'dplcindexline=',1)
    else if CheckINIAny('dplchead',s) then dplchead := Explode(s,'dplchead=',1)
    else if CheckINIAny('dplcfoot',s) then dplcfoot := Explode(s,'dplcfoot=',1)
    else if CheckINIAny('dplcline',s) then dplcline := Explode(s,'dplcline=',1)
    else if CheckINIAny('dplc',s) then dplcmode := Explode(s,'dplc=',1)
    else if CheckINI('palfile',s) then palfilename := Explode(s,'palfile=',1)
    else if CheckINIAny('palsize',s) then palsize := Explode(s,'palsize=',1);
    if mapasm = '' then mapasm := outfolder+'_mappings.asm'; // Default mappings file.
    end;
  WriteLn(IntToStr(spritecount)+' sprites found.');
  WriteLn(IntToStr(piececount)+' pieces found.');
  if AnsiPos('{',gfxfilename) <> 0 then splitgfxfile := true;
  CloseFile(inifile);
  if not Assigned(PNG) then
    begin
    WriteLn('PNG not defined.');
    exit;
    end;
  SetLength(spritetiles,spritecount);
  SetLength(spritepieces,spritecount);
  SetLength(pieceglobal,piececount);
  SetLength(piecelocal,piececount);
  tilecount := 0;

  { Read each sprite and create gfx files. }

  if not splitgfxfile then NewFile(0); // Start with blank file (single file).
  for i := 0 to spritecount-1 do
    begin
    if splitgfxfile then NewFile(0); // Start with blank file (different file per sprite).
    for j := 0 to piececount-1 do
      if PieceInSprite(j,i) then // Check if piece is inside sprite.
        begin
        WritePiece(piecetable[j*4],piecetable[(j*4)+1],piecetable[(j*4)+2] and 3,piecetable[(j*4)+3]); // Write piece to file.
        piecelocal[j] := spritetiles[i];
        pieceglobal[j] := tilecount;
        spritetiles[i] := spritetiles[i]+piecesize[piecetable[(j*4)+3]]; // Track total size of sprite in tiles.
        tilecount := tilecount+piecesize[piecetable[(j*4)+3]]; // Track size of all tiles.
        spritepieces[i] := spritepieces[i]+1; // Track piece count per sprite.
        end;
    s := ReplaceStr(gfxfilename,'{name}',spritenames[i]);
    if splitgfxfile and (spritepieces[i] > 0) then SaveFile(outfolder+s); // Save sprite file if it contained pieces.
    end;
  if not splitgfxfile then
    begin
    SaveFile(outfolder+gfxfilename);
    WriteLn('Graphics file: '+outfolder+gfxfilename);
    end;
  WriteLn(IntToStr(tilecount)+' tiles found, totalling '+IntToStr(tilecount*32)+' bytes.');

  { Open main mappings file. }

  WriteLn('Mappings file: '+mapasm);
  AssignFile(mapasmfile,mapasm); // Open asm file.
  ReWrite(mapasmfile); // Make file editable.
  currfile := @mapasmfile;

  { Write mappings file. }

  // Index
  WriteASM(currfile^,mapindexhead);
  for i := 0 to spritecount-1 do
    WriteASM(currfile^,FormatIndex(mapindexline,i));
  WriteASM(currfile^,mapindexfoot);

  for i := 0 to spritecount-1 do
    begin
    // Header
    WriteASM(currfile^,FormatHeader(maphead,i));
    // Content
    for j := 0 to piececount-1 do
      if PieceInSprite(j,i) then // Check if piece is inside sprite.
        WriteASM(currfile^,FormatMapLine(mapline,i,j));
    // Footer
    WriteASM(currfile^,FormatFooter(mapfoot,i));
    if dplcmode = 'inline' then
      begin
      // Inline DPLC header
      WriteASM(currfile^,FormatHeader(dplchead,i));
      // Inline DPLC content
      for j := 0 to piececount-1 do
        if PieceInSprite(j,i) then // Check if piece is inside sprite.
          WriteASM(currfile^,FormatDPLCLine(dplcline,i,j));
      // Inline DPLC footer
      WriteASM(currfile^,FormatFooter(dplcfoot,i));
      end;
    end;

  { Write DPLC file. }

  if (dplcmode = 'yes') or (dplcasm <> '') then
    begin
    if dplcasm <> '' then
      begin
      WriteLn('DPLC file: '+dplcasm);
      AssignFile(dplcasmfile,dplcasm); // Open asm file.
      ReWrite(dplcasmfile); // Make file editable.
      currfile := @dplcasmfile; // Switch to DPLC asm file.
      end;
    // Index
    WriteASM(currfile^,dplcindexhead);
    for i := 0 to spritecount-1 do
      WriteASM(currfile^,FormatIndex(dplcindexline,i));
    WriteASM(currfile^,dplcindexfoot);

    for i := 0 to spritecount-1 do
      begin
      // Header
      WriteASM(currfile^,FormatHeader(dplchead,i));
      // Content
      for j := 0 to piececount-1 do
        if PieceInSprite(j,i) then // Check if piece is inside sprite.
          WriteASM(currfile^,FormatDPLCLine(dplcline,i,j));
      // Footer
      WriteASM(currfile^,FormatFooter(dplcfoot,i));
      end;
    end;

  { Write gfx file list. }

  if gfxasm <> '' then
    begin
    WriteLn('Graphics list file: '+gfxasm);
    AssignFile(gfxasmfile,gfxasm); // Open asm file.
    ReWrite(gfxasmfile); // Make file editable.
    currfile := @gfxasmfile; // Switch to gfx asm file.
    end;
  for i := 0 to spritecount-1 do
    begin
    if spritetiles[i] = 0 then continue; // Don't list blank sprites.
    s := ReplaceStr(gfxline,'{file}',outfolder+gfxfilename);
    s := ReplaceStr(s,'{filenopath}',gfxfilename);
    s := ReplaceStr(s,'{name}',spritenames[i]);
    WriteASM(currfile^,s);
    if not splitgfxfile then break; // Only run once for single gfx file.
    end;

  { Write palette. }

  if palfilename <> '' then
    begin
    if palsize <> '' then NewFile(Min(StrToInt(palsize)*2,128)) // Create blank palette file.
    else NewFile(palused*2);
    for i := 0 to (fs div 2)-1 do
      WriteWord(i*2,TColorToMD(palarray[i])); // Write palette.
    WriteLn('Palette file: '+outfolder+palfilename);
    SaveFile(outfolder+palfilename); // Save palette file.
    end;

  CloseFile(mapasmfile);
  if dplcasm <> '' then CloseFile(dplcasmfile);
  if gfxasm <> '' then CloseFile(gfxasmfile);
end.