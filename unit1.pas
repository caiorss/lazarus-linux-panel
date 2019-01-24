unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uPSComponent, Forms, Controls, Graphics, Dialogs,
  StdCtrls, process, unix, LCLIntf, ValEdit, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonQuit: TButton;
    buttonLaunch: TButton;
    buttonInvertColors: TButton;
    buttonAbout: TButton;
    ComboBox1: TComboBox;
    TrayIcon1: TTrayIcon;
    procedure buttonAboutClick(Sender: TObject);
    procedure buttonInvertColorsClick(Sender: TObject);
    procedure buttonLaunchClick(Sender: TObject);
    procedure buttonQuitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

//=========== Functions =======================//

function LaunchApplication(commandLine: String): Integer;
var
   Proc : TProcess;
begin
  // Requires: use process, unix;   
   Proc := TProcess.Create(nil);
   Proc.CommandLine := commandLine;
   Proc.Execute;
   Result := 0;  // Dummy return value
end;


//=========== Form Handles ===================//

procedure TForm1.FormCreate(Sender: TObject);
begin
   TrayIcon1.Visible := True;
   TrayIcon1.Hint    := 'Hide';
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
     // Minimize form instead of closing it when the user click at the (x)
     // button
     CanClose := False;
     Hide;
end;

//============= Controls Handles =================//

procedure TForm1.buttonInvertColorsClick(Sender: TObject);
var
  // Requires: use process, unix;
  Proc : TProcess;
begin
  Proc := TProcess.Create(nil);
  Proc.CommandLine := 'xcalib -i -a';
  Proc.Execute
end;

procedure TForm1.buttonLaunchClick(Sender: TObject);
begin
  LaunchApplication(ComboBox1.Text);
//  Proc := TProcess.Create(nil);
//  Proc.CommandLine := ComboBox1.Text;
//  Proc.Execute
end;

// Exit Application
procedure TForm1.buttonQuitClick(Sender: TObject);
begin
   // Exit application
   Application.Terminate;
end;


procedure TForm1.buttonAboutClick(Sender: TObject);
begin
   // Requires: uses LCLIntf;
   OpenUrl('https://reddit.com/r/cpp');
end;


procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  if Form1.WindowState = TWindowState.wsNormal then
  begin
    Form1.Hide;
    Form1.WindowState := TWindowState.wsMinimized
  end
  else
  begin
    Form1.Show;
    Form1.WindowState := TWindowState.wsNormal;
  end;
end;



end.

