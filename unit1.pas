unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uPSComponent, Forms, Controls, Graphics, Dialogs,
  StdCtrls, process, unix, LCLIntf, ValEdit, ExtCtrls, ActnList, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonSetKeyboard: TBitBtn;
    ButtonSwapCtrlCapslock: TButton;
    buttonQuit: TButton;
    buttonLaunch: TButton;
    buttonInvertColors: TButton;
    buttonAbout: TButton;
    ComboBox1: TComboBox;
    TrayIcon1: TTrayIcon;
    procedure ButtonSetKeyboardClick(Sender: TObject);
    procedure buttonAboutClick(Sender: TObject);
    procedure buttonInvertColorsClick(Sender: TObject);
    procedure buttonLaunchClick(Sender: TObject);
    procedure buttonQuitClick(Sender: TObject);
    procedure ButtonSwapCtrlCapslockClick(Sender: TObject);
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

// Requires: use process, unix;
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
begin
  // Note: Requires the application xcalib installed
  LaunchApplication('xcalib -i -a');
end;

procedure TForm1.buttonLaunchClick(Sender: TObject);
begin
  LaunchApplication(ComboBox1.Text);
end;

// Exit Application
procedure TForm1.buttonQuitClick(Sender: TObject);
begin
   // Exit application
   Application.Terminate;
end;

procedure TForm1.ButtonSwapCtrlCapslockClick(Sender: TObject);
begin
   LaunchApplication('setxkbmap -option "ctrl:swapcaps');
end;


procedure TForm1.buttonAboutClick(Sender: TObject);
begin
   // Requires: uses LCLIntf;
   OpenUrl('https://reddit.com/r/cpp');
end;

procedure TForm1.ButtonSetKeyboardClick(Sender: TObject);
begin
   LaunchApplication('setxkbmap -model abnt2 -layout br -variant abnt2')
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

