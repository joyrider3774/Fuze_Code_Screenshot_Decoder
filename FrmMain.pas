unit FrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, System.Math;

type
  TMainForm = class(TForm)
    edtfilename: TEdit;
    btnprocess: TButton;
    btnselect: TButton;
    OpenFileDialog: TFileOpenDialog;
    mmo1: TMemo;
    lblcrc: TLabel;
    btnClear: TButton;
    btnSave: TButton;
    SaveFileDialog: TFileSaveDialog;
    procedure btnprocessClick(Sender: TObject);
    procedure btnselectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    crctable: array[0..256*8] of UINT32;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{$RANGECHECKS OFF}


procedure TMainForm.btnClearClick(Sender: TObject);
begin
  mmo1.Lines.Text := '';
end;

procedure TMainForm.btnprocessClick(Sender: TObject);
var
  x,y, increment : Integer;
  charc : Byte;
  bit: array[0..7] of Integer;
  r,g,b : LongInt;
  bmp: TBitmap;
  jpeg: TJPEGImage;
  strings: string;
  Line: PByteArray;
  crc: UINT32;
  sExt: String;
begin
  sExt := UpperCase(ExtractFileExt(edtfilename.text));
  if not FileExists(edtfilename.Text) or not ((sExt = '.JPG') or (sExt = '.BMP')) then
  begin
    Application.MessageBox('Please Select a valid filename first using select button','Warning', MB_OK + MB_ICONWARNING);
    exit;
  end;

  bmp := TBitmap.Create;
  try
    if sExt = '.JPG' then
    begin
      jpeg := TJPEGImage.Create;
      try
        jpeg.LoadFromFile(edtfilename.text);
        bmp.Assign(jpeg);
      finally
        FreeAndNil(jpeg);
      end;
    end
    else
      bmp.LoadFromFile(edtfilename.text);
    bmp.PixelFormat := pf24bit;

    strings := '';
    charc := 0;
    increment := 0;
    bmp.Canvas.Lock;
    mmo1.Lines.BeginUpdate;
    crc := $FFFFFFFF;
    try
      for y := 0 to bmp.Height -1 do
      begin
        Line := bmp.ScanLine[y];
        for x := 0 to (bmp.Width - 1)  do
        begin
          r := Line[X*3]; // Red value
          g := Line[X*3+1]; // Green value
          b := Line[X*3+2]; // Blue value
          if (r < 128) and (g < 128) and (b <128) then
            bit[increment] := 0
          else
            bit[increment] := 1;

          if increment = 7 then
          begin
            increment := 0;
            charc := bit[0] + (bit[1] shl 1) + (bit[2] shl 2) + (bit[3] shl 3) +
                     (bit[4] shl 4) + (bit[5] shl 5) + (bit[6] shl 6) + (bit[7] shl 7);

            if Charc = 0 then Break;

            crc := (crc shr 8) xor (crctable[(crc and $ff) xor Charc]);
            if charc = 10 then
            begin
              strings := strings + #13#10;
            end
            else
                strings := strings + Chr(charc);
          end
          else
            increment := increment + 1;
        end;

        if Charc = 0 then Break;
      end
    finally
      mmo1.Lines.Text := mmo1.Lines.Text + strings;
      mmo1.Lines.EndUpdate;
    end;
     crc := not crc;
     lblcrc.caption := 'CRC:' + Crc.ToString;
  finally
    bmp.Canvas.Unlock;
    FreeAndNil(bmp);
  end;
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
begin
  if SaveFileDialog.Execute then
  begin
    ForceDirectories(ExtractFilePath((SaveFileDialog.FileName)));
    mmo1.Lines.SaveToFile(SaveFileDialog.FileName);
  end;
end;

procedure TMainForm.btnselectClick(Sender: TObject);
begin
  if openfiledialog.Execute then
    edtfilename.Text := openfiledialog.FileName;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  k, j : UINT32;
  rem: UINT32;
begin
  for k := 0 to 255 do
  begin
    rem := k;
    for j := 0 to 7 do
    begin
      if rem and 1 = 1 then
      begin
        rem := rem shr 1;
        rem := rem xor $EDB88320;
      end
      else
        rem := rem shr 1;
    end;
    crctable[k] := rem;
  end;
end;


end.
