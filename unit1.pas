unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ComCtrls, ExtDlgs, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    ColorDialog1: TColorDialog;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    SpinEdit1: TSpinEdit;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseLeave(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  draw: boolean;
  bmp: TBitmap;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  draw := True;
  bmp.Canvas.MoveTo(x, y);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp := TBitmap.Create;
  bmp.Width := 800;
  bmp.Height := 600;
  PaintBox1.Width := 800;
  PaintBox1.Height := 600;
  PaintBox1.Top := 10;
  PaintBox1.Left := 10;
  bmp.Canvas.FillRect(0, 0, bmp.Width, bmp.Height);
  PaintBox1Paint(Sender);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Draw(0, 0, bmp);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  bmp.Canvas.Pen.Width := SpinEdit1.Value;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    bmp.LoadFromFile(OpenPictureDialog1.FileName);
    PaintBox1Paint(Sender);
    StatusBar1.Panels[1].Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    bmp.SaveToFile(SavePictureDialog1.FileName);
    StatusBar1.Panels[1].Text := SavePictureDialog1.FileName;
  end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  if MenuItem5.Checked then
  begin
    MenuItem5.Checked := False;
    StatusBar1.Visible := False;
  end
  else
  begin
    MenuItem5.Checked := True;
    StatusBar1.Visible := True;
  end;
end;

procedure TForm1.PaintBox1MouseLeave(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := '';
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if draw then
  begin
    bmp.Canvas.LineTo(x, y);
    PaintBox1Paint(Sender);
  end;
  StatusBar1.Panels[0].Text := ' ' + X.ToString + ', ' + Y.ToString;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  draw := False;
end;

procedure TForm1.Panel2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    bmp.Canvas.Pen.Color := ColorDialog1.Color;
    Panel2.Color := ColorDialog1.Color;
  end;
end;

end.
