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
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
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
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Panel2Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  draw: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  draw := True;
  Image1.Canvas.MoveTo(x, y);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Width := 800;
  Image1.Height := 600;
  Image1.Top := 10;
  Image1.Left := 10;
  Image1.Canvas.FillRect(0, 0, Image1.Width, Image1.Height);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Image1.Canvas.Pen.Width := SpinEdit1.Value;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    StatusBar1.Panels[1].Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
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

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := '';
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if draw then
  begin
    Image1.Canvas.LineTo(x, y);
  end;
  StatusBar1.Panels[0].Text := ' ' + X.ToString + ', ' + Y.ToString;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  draw := False;
end;

procedure TForm1.Panel2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    Image1.Canvas.Pen.Color := ColorDialog1.Color;
    Panel2.Color := ColorDialog1.Color;
  end;
end;

end.
