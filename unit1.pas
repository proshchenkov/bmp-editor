unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ComCtrls, ExtDlgs, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
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
    StatusBar1: TStatusBar;
    TaskDialog1: TTaskDialog;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure PaintBox1MouseLeave(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Panel2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  draw: boolean;
  bmp: TBitmap;
  x0, y0: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  draw := True;
  PaintBox1.Canvas.MoveTo(x, y);
  PaintBox1.Canvas.Pixels[x, y] := ColorDialog1.Color;
  x0 := x;
  y0 := y;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  StatusBar1.Panels[1].Text :=
    ' ' + PaintBox1.Width.ToString + ' x ' + PaintBox1.Height.ToString + ' пкс';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp := TBitmap.Create;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  PaintBox1.Canvas.Pen.Width := ComboBox1.ItemIndex + 1;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    bmp.LoadFromFile(OpenPictureDialog1.FileName);
    PaintBox1.Canvas.Draw(0, 0, bmp);
    bmp.Free;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    bmp.Canvas.CopyRect(Rect(0, 0, PaintBox1.Width, PaintBox1.Height),
      PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
    bmp.SaveToFile(SavePictureDialog1.FileName);
    bmp.Free;
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
    PaintBox1.Canvas.LineTo(x, y);
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
    PaintBox1.Canvas.Pen.Color := ColorDialog1.Color;
    Panel2.Color := ColorDialog1.Color;
  end;
end;

end.
