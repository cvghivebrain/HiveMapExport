program PHiveMapExport;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  Windows,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  StrUtils,
  FileFunc in 'FileFunc.pas',
  ExplodeFunc in 'ExplodeFunc.pas';

var
  i, j, spritecount, piececount: integer;
  outfolder, inipath, s, mapasm, dplcasm, gfxasm, gfxline,
  mapindexhead, mapindexfoot, mapindexline, maphead, mapfoot, mapline: string;
  inifile, mapasmfile, dplcasmfile, gfxasmfile: textfile;
  PNG: TPNGImage;
  palarray: array[0..63] of TColor;
  spritenames: array of string;
  spritetable, piecetable: array of integer;

const
  piecewidth: array[0..15] of integer = (8,8,8,8,16,16,16,16,24,24,24,24,32,32,32,32);
  pieceheight: array[0..15] of integer = (8,16,24,32,8,16,24,32,8,16,24,32,8,16,24,32);

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
  AssignFile(inifile,ParamStr(1)); // Open ini file.
  Reset(inifile);
  PNG := TPNGImage.Create; // Initialise PNG.
  while not eof(inifile) do
    begin
    ReadLn(inifile,s);
    if AnsiPos('image=',s) = 1 then
      try
      PNG.LoadFromFile(inipath+Explode(s,'image=',1)); // Load PNG.
      except
      WriteLn('Failed to load image.');
      exit;
      end
    else if AnsiPos('palette=',s) = 1 then
      begin
      s := Explode(s,'palette=',1);
      for i := 0 to 63 do
        begin
        if Explode(s,',',i) = '' then break; // Stop at end of palette.
        palarray[i] := StrToTColor(Explode(s,',',i)); // Write palette.
        end;
      end
    else if AnsiPos('sprite=',s) = 1 then
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
    else if AnsiPos('piece=',s) = 1 then
      begin
      s := Explode(s,'piece=',1);
      SetLength(piecetable,Length(piecetable)+4); // Add piece.
      piecetable[piececount*4] := StrToInt(Explode(s,',',0)); // Piece x pos.
      piecetable[(piececount*4)+1] := StrToInt(Explode(s,',',1)); // Piece y pos.
      piecetable[(piececount*4)+2] := StrToInt(Explode(s,',',2)); // Piece palette.
      piecetable[(piececount*4)+3] := StrToInt(Explode(s,',',3)); // Piece size.
      Inc(piececount);
      end
    else if AnsiPos('mapasmfile=',s) = 1 then mapasm := outfolder+Explode(s,'mapasmfile=',1)
    else if AnsiPos('dplcasmfile=',s) = 1 then dplcasm := outfolder+Explode(s,'dplcasmfile=',1)
    else if AnsiPos('gfxasmfile=',s) = 1 then gfxasm := outfolder+Explode(s,'gfxasmfile=',1)
    else if AnsiPos('gfxline=',s) = 1 then gfxline := Explode(s,'gfxline=',1)
    else if AnsiPos('mapindexhead=',s) = 1 then mapindexhead := Explode(s,'mapindexhead=',1)
    else if AnsiPos('mapindexfoot=',s) = 1 then mapindexfoot := Explode(s,'mapindexfoot=',1)
    else if AnsiPos('mapindexline=',s) = 1 then mapindexline := Explode(s,'mapindexline=',1)
    else if AnsiPos('maphead=',s) = 1 then maphead := Explode(s,'maphead=',1)
    else if AnsiPos('mapfoot=',s) = 1 then mapfoot := Explode(s,'mapfoot=',1)
    else if AnsiPos('mapline=',s) = 1 then mapline := Explode(s,'mapline=',1);
    if mapasm = '' then mapasm := outfolder+'_mappings.asm'; // Default mappings file.
    end;
  WriteLn(IntToStr(spritecount)+' sprites found.');
  WriteLn(IntToStr(piececount)+' pieces found.');
  CloseFile(inifile);
  if not Assigned(PNG) then
    begin
    WriteLn('PNG not defined.');
    exit;
    end;

  { Read each sprite. }

  for i := 0 to spritecount-1 do
    begin
    NewFile(0); // Start with blank file.
    for j := 0 to piececount-1 do
      if PieceInSprite(j,i) then // Check if piece is inside sprite.
        begin
        WritePiece(piecetable[j*4],piecetable[(j*4)+1],piecetable[(j*4)+2],piecetable[(j*4)+3]); // Write piece to file.
        end;
    if fs > 0 then SaveFile(outfolder+spritenames[i]+'.bin'); // Save sprite file if it contained pieces.
    end;

  { Open main mappings file. }

  AssignFile(mapasmfile,mapasm); // Open asm file.
  ReWrite(mapasmfile); // Make file editable.

  { Write mappings file. }

  WriteASM(mapasmfile,mapindexhead);
  for i := 0 to spritecount-1 do
    begin
    s := ReplaceStr(mapindexline,'{name}',spritenames[i]);
    WriteASM(mapasmfile,s);
    end;
  WriteASM(mapasmfile,mapindexfoot);
  for i := 0 to spritecount-1 do
    begin
    s := ReplaceStr(maphead,'{name}',spritenames[i]);
    WriteASM(mapasmfile,s);
    s := ReplaceStr(mapfoot,'{name}',spritenames[i]);
    WriteASM(mapasmfile,s);
    end;

  { Write gfx file list. }

  if gfxasm <> '' then
    begin
    AssignFile(gfxasmfile,gfxasm); // Open asm file.
    ReWrite(gfxasmfile); // Make file editable.
    end;
  for i := 0 to spritecount-1 do
    begin
    s := ReplaceStr(gfxline,'{name}',spritenames[i]);
    s := ReplaceStr(s,'{file}',outfolder+spritenames[i]+'.bin');
    s := ReplaceStr(s,'{filenopath}',spritenames[i]+'.bin');
    if gfxasm <> '' then WriteASM(gfxasmfile,s)
    else WriteASM(mapasmfile,s);
    end;

  CloseFile(mapasmfile);
  if dplcasm <> '' then CloseFile(dplcasmfile);
  if gfxasm <> '' then CloseFile(gfxasmfile);
end.