
; -- CodeClasses.iss --
;
; This script shows how to use the WizardForm object and the various VCL classes.

[Setup]
AppName=My Program
AppVerName=My Program version 1.5
CreateAppDir=no
DisableProgramGroupPage=yes
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe
WindowVisible=yes

[Files]
Source: compiler:WizModernSmallImage.bmp; Flags: dontcopy

[Code]
procedure AboutButtonOnClick(Sender: TObject);
begin
  MsgBox('This demo shows some features of the WizardForm object and the various VCL classes.', mbInformation, mb_Ok);
end;

procedure URLLabelOnClick(Sender: TObject);
var
  Dummy: Integer;
begin
  InstShellExec('http://www.innosetup.com', '', '', SW_SHOWNORMAL, Dummy);
end;

procedure InitializeWizard();
var
  AboutButton, CancelButton: TButton;
  URLLabel: TNewStaticText;
  BackgroundBitmapImage: TBitmapImage;
  BackgroundBitmapText: TNewStaticText;
begin
  CancelButton := WizardForm.CancelButton;

  AboutButton := TButton.Create(WizardForm);
  AboutButton.Left := WizardForm.ClientWidth - CancelButton.Left - CancelButton.Width;
  AboutButton.Top := CancelButton.Top;
  AboutButton.Width := CancelButton.Width;
  AboutButton.Height := CancelButton.Height;
  AboutButton.Caption := '&About...';
  AboutButton.OnClick := @AboutButtonOnClick;
  AboutButton.Parent := WizardForm;
  
  URLLabel := TNewStaticText.Create(WizardForm);
  URLLabel.Top := AboutButton.Top + AboutButton.Height - URLLabel.Height - 2;
  URLLabel.Left := AboutButton.Left + AboutButton.Width + 20;
  URLLabel.Caption := 'www.innosetup.com';
  URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderLine];
  URLLabel.Font.Color := clBlue;
  URLLabel.Cursor := crHand;
  URLLabel.OnClick := @URLLabelOnClick;
  URLLabel.Parent := WizardForm;

  BackgroundBitmapImage := TBitmapImage.Create(MainForm);
  BackgroundBitmapImage.AutoSize := True;
  BackgroundBitmapImage.Bitmap := WizardForm.WizardBitmapImage.Bitmap;
  BackgroundBitmapImage.Left := 50;
  BackgroundBitmapImage.Top := 100;
  BackgroundBitmapImage.Parent := MainForm;
  
  BackgroundBitmapText := TNewStaticText.Create(MainForm);
  BackgroundBitmapText.Caption := 'TBitmapImage';
  BackgroundBitmapText.Left := BackGroundBitmapImage.Left;
  BackgroundBitmapText.Top := BackGroundBitmapImage.Top + BackGroundBitmapImage.Height + 8;
  BackgroundBitmapText.Parent := MainForm;
end;

procedure ButtonOnClick(Sender: TObject);
begin
  MsgBox('You clicked the button!', mbInformation, mb_Ok);
end;

procedure FormButtonOnClick(Sender: TObject);
var
  Form: TForm;
  Button: TButton;
begin
  Form := TForm.Create(WizardForm);
  Form.Width := 256;
  Form.Height := 256;
  Form.Caption := 'TForm';
  Form.Position := poScreenCenter;

  Button := TButton.Create(Form);
  Button.Parent := Form;
  Button.Left := 8;
  Button.Top := Form.ClientHeight - Button.Height - 10;
  Button.Caption := 'Close';
  Button.ModalResult := mrOk;

  Form.ActiveControl := Button;

  Form.ShowModal();
  Form.Release();
end;

function ScriptDlgPages(CurPage: Integer; BackClicked: Boolean): Boolean;
var
  CurSubPage: Integer;
  Next: Boolean;
  Button, FormButton: TButton;
  CheckBox: TCheckBox;
  Edit: TEdit;
  PasswordEdit: TPasswordEdit;
  Memo: TMemo;
  Lbl, ProgressBarLabel: TLabel;
  ComboBox: TComboBox;
  ListBox: TListBox;
  StaticText: TNewStaticText;
  ProgressBar: TNewProgressBar;
  CheckListBox, CheckListBox2: TNewCheckListBox;
  FolderTreeView: TFolderTreeView;
  BitmapImage, BitmapImage2, BitmapImage3: TBitmapImage;
  BitmapFileName: String;
  RichEditViewer: TRichEditViewer;
begin
  if (not BackClicked and (CurPage = wpWelcome)) or (BackClicked and (CurPage = wpReady)) then begin
    if not BackClicked then
      CurSubPage := 0
    else
      CurSubPage := 5;
    ScriptDlgPageOpen();
    ScriptDlgPageSetCaption('Custom wizard page controls');
    ScriptDlgPageSetSubCaption2('');
    while (CurSubPage >= 0) and (CurSubPage <= 5) and not Terminated do begin
      case CurSubPage of
        0:
          begin
            ScriptDlgPageSetSubCaption1('TButton and others');
            ScriptDlgPageClearCustom();

            Button := TButton.Create(WizardForm.ScriptDlgPanel);
            Button.Caption := 'TButton';
            Button.OnClick := @ButtonOnClick;
            Button.Parent := WizardForm.ScriptDlgPanel;

            CheckBox := TCheckBox.Create(WizardForm.ScriptDlgPanel);
            CheckBox.Top := Button.Top + Button.Height + 8;
            CheckBox.Caption := 'TCheckBox';
            CheckBox.Checked := True;
            CheckBox.Width := WizardForm.ScriptDlgPanel.Width;
            CheckBox.Parent := WizardForm.ScriptDlgPanel;

            Edit := TEdit.Create(WizardForm.ScriptDlgPanel);
            Edit.Top := CheckBox.Top + CheckBox.Height + 8;
            Edit.Text := 'TEdit';
            Edit.Width := WizardForm.ScriptDlgPanel.Width div 2 - 8;
            Edit.Parent := WizardForm.ScriptDlgPanel;

            PasswordEdit := TPasswordEdit.Create(WizardForm.ScriptDlgPanel);
            PasswordEdit.Left := Edit.Left + Edit.Width + 16;
            PasswordEdit.Top := CheckBox.Top + CheckBox.Height + 8;
            PasswordEdit.Text := 'TPasswordEdit';
            PasswordEdit.Width := Edit.Width;
            PasswordEdit.Parent := WizardForm.ScriptDlgPanel;

            Memo := TMemo.Create(WizardForm.ScriptDlgPanel);
            Memo.Top := Edit.Top + Edit.Height + 8;
            Memo.ScrollBars := ssVertical;
            Memo.Width := WizardForm.ScriptDlgPanel.Width;
            Memo.Parent := WizardForm.ScriptDlgPanel;
            Memo.Lines.Text := 'TMemo';

            Lbl := TLabel.Create(WizardForm.ScriptDlgPanel);
            Lbl.Top := Memo.Top + Memo.Height + 8;
            Lbl.Caption := 'TLabel';
            Lbl.AutoSize := True;
            Lbl.Parent := WizardForm.ScriptDlgPanel;

            FormButton := TButton.Create(WizardForm.ScriptDlgPanel);
            FormButton.Top := Lbl.Top + Lbl.Height + 8;
            FormButton.Caption := 'TForm';
            FormButton.OnClick := @FormButtonOnClick;
            FormButton.Parent := WizardForm.ScriptDlgPanel;

            Next := ScriptDlgPageProcessCustom();
          end;
        1:
          begin
            ScriptDlgPageSetSubCaption1('TComboBox and others');
            ScriptDlgPageClearCustom();

            ComboBox := TComboBox.Create(WizardForm.ScriptDlgPanel);
            ComboBox.Width := WizardForm.ScriptDlgPanel.Width;
            ComboBox.Parent := WizardForm.ScriptDlgPanel;
            ComboBox.Items.Add('TComboBox');
            ComboBox.ItemIndex := 0;

            ListBox := TListBox.Create(WizardForm.ScriptDlgPanel);
            ListBox.Top := ComboBox.Top + ComboBox.Height + 8;
            ListBox.Width := WizardForm.ScriptDlgPanel.Width;
            ListBox.Parent := WizardForm.ScriptDlgPanel;
            ListBox.Items.Add('TListBox');
            ListBox.ItemIndex := 0;

            StaticText := TNewStaticText.Create(WizardForm.ScriptDlgPanel);
            StaticText.Top := ListBox.Top + ListBox.Height + 8;
            StaticText.Caption := 'TNewStaticText';
            StaticText.AutoSize := True;
            StaticText.Parent := WizardForm.ScriptDlgPanel;

            ProgressBarLabel := TLabel.Create(WizardForm.ScriptDlgPanel);
            ProgressBarLabel.Top := StaticText.Top + StaticText.Height + 8;
            ProgressBarLabel.Caption := 'TNewProgressBar';
            ProgressBarLabel.AutoSize := True;
            ProgressBarLabel.Parent := WizardForm.ScriptDlgPanel;

            ProgressBar := TNewProgressBar.Create(WizardForm.ScriptDlgPanel);
            ProgressBar.Left := ProgressBarLabel.Width + 8;
            ProgressBar.Top := ProgressBarLabel.Top;
            ProgressBar.Parent := WizardForm.ScriptDlgPanel;
            ProgressBar.Position := 25;
            ProgressBar.Width := WizardForm.ScriptDlgPanel.Width - ProgressBar.Left;
            ProgressBar.Height := ProgressBarLabel.Height + 8;

            Next := ScriptDlgPageProcessCustom();
          end;
        2:
          begin
            ScriptDlgPageSetSubCaption1('TNewCheckListBox');
            ScriptDlgPageClearCustom();

            CheckListBox := TNewCheckListBox.Create(WizardForm.ScriptDlgPanel);
            CheckListBox.Flat := True;
            CheckListBox.Width := WizardForm.ScriptDlgPanel.Width;
            CheckListBox.Parent := WizardForm.ScriptDlgPanel;
            CheckListBox.AddCheckBox('TNewCheckListBox', '', 0, True, True, False, nil);
            CheckListBox.AddRadioButton('TNewCheckListBox', '', 1, 0, True, True, nil);
            CheckListBox.AddRadioButton('TNewCheckListBox', '', 1, 0, False, True, nil);
            CheckListBox.AddCheckBox('TNewCheckListBox', '', 0, True, True, False, nil);

            CheckListBox2 := TNewCheckListBox.Create(WizardForm.ScriptDlgPanel);
            CheckListBox2.BorderStyle := bsNone;
            CheckListBox2.Color := WizardForm.Color;
            CheckListBox2.MinItemHeight := WizardForm.TasksList.MinItemHeight;
            CheckListBox2.ShowLines := False;
            CheckListBox2.WantTabs := True;
            CheckListBox2.Flat := True;
            CheckListBox2.Top := CheckListBox.Top + CheckListBox.Height + 8;
            CheckListBox2.Width := WizardForm.ScriptDlgPanel.Width;
            CheckListBox2.Parent := WizardForm.ScriptDlgPanel;
            CheckListBox2.AddGroup('TNewCheckListBox', '', 0, nil);
            CheckListBox2.AddRadioButton('TNewCheckListBox', '', 0, 0, True, True, nil);
            CheckListBox2.AddRadioButton('TNewCheckListBox', '', 0, 0, False, True, nil);

            Next := ScriptDlgPageProcessCustom();
          end;
        3:
          begin
            ScriptDlgPageSetSubCaption1('TFolderTreeView');
            ScriptDlgPageClearCustom();

            FolderTreeView := TFolderTreeView.Create(WizardForm.ScriptDlgPanel);
            FolderTreeView.Width := WizardForm.ScriptDlgPanel.Width;
            FolderTreeView.Height := WizardForm.ScriptDlgPanel.Height;
            FolderTreeView.Parent := WizardForm.ScriptDlgPanel;
            FolderTreeView.Directory := ExpandConstant('{src}');

            Next := ScriptDlgPageProcessCustom();
          end;
        4:
          begin
            ScriptDlgPageSetSubCaption1('TBitmapImage');
            ScriptDlgPageClearCustom();

            BitmapFileName := ExpandConstant('{tmp}\WizModernSmallImage.bmp');
            if not FileExists(BitmapFileName) then
              ExtractTemporaryFile(ExtractFileName(BitmapFileName));

            BitmapImage := TBitmapImage.Create(WizardForm.ScriptDlgPanel);
            BitmapImage.AutoSize := True;
            BitmapImage.Bitmap.LoadFromFile(BitmapFileName);
            BitmapImage.Parent := WizardForm.ScriptDlgPanel;

            BitmapImage2 := TBitmapImage.Create(WizardForm.ScriptDlgPanel);
            BitmapImage2.BackColor := $400000;
            BitmapImage2.Bitmap := BitmapImage.Bitmap;
            BitmapImage2.Center := True;
            BitmapImage2.Left := BitmapImage.Width + 10;
            BitmapImage2.Height := 2*BitmapImage.Height;
            BitmapImage2.Width := 2*BitmapImage.Width;
            BitmapImage2.Parent := WizardForm.ScriptDlgPanel;

            BitmapImage3 := TBitmapImage.Create(WizardForm.ScriptDlgPanel);
            BitmapImage3.Bitmap := BitmapImage.Bitmap;
            BitmapImage3.Stretch := True;
            BitmapImage3.Left := 3*BitmapImage.Width + 20;
            BitmapImage3.Height := 4*BitmapImage.Height;
            BitmapImage3.Width := 4*BitmapImage.Width;
            BitmapImage3.Parent := WizardForm.ScriptDlgPanel;

            Next := ScriptDlgPageProcessCustom();
          end;
        5:
          begin
            ScriptDlgPageSetSubCaption1('TRichViewer');
            ScriptDlgPageClearCustom();

            RichEditViewer := TRichEditViewer.Create(WizardForm.ScriptDlgPanel);
            RichEditViewer.Parent := WizardForm.ScriptDlgPanel;
            RichEditViewer.Scrollbars := ssVertical;
            RichEditViewer.UseRichEdit := True;
            RichEditViewer.RTFText := '{\rtf1\ansi\ansicpg1252\deff0\deflang1043{\fonttbl{\f0\fswiss\fcharset0 Arial;}}{\colortbl ;\red255\green0\blue0;\red0\green128\blue0;\red0\green0\blue128;}\viewkind4\uc1\pard\f0\fs20 T\cf1 Rich\cf2 Edit\cf3 Viewer\cf0\par}';
            RichEditViewer.ReadOnly := True;
            RichEditViewer.Width := WizardForm.ScriptDlgPanel.Width;
            RichEditViewer.Height := WizardForm.ScriptDlgPanel.Height;

            Next := ScriptDlgPageProcessCustom();
          end;
      end;
      if Next then
        CurSubPage := CurSubPage + 1
      else
        CurSubPage := CurSubPage - 1;
    end;
    if not BackClicked then
      Result := Next
    else
      Result := not Next;
    ScriptDlgPageClose(not Result);
  end else
    Result := True;
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := ScriptDlgPages(CurPage, False);
end;

function BackButtonClick(CurPage: Integer): Boolean;
begin
  Result := ScriptDlgPages(CurPage, True);
end;


