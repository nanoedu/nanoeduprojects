inherited Spectroscopyspt: TSpectroscopyspt
  Caption = 'Spectroscopyspt'
  PixelsPerInch = 120
  TextHeight = 16
  inherited PanelMain: TPanel
    inherited Panel: TPanel
      inherited ControlPanel: TPanel
        inherited Panel3: TPanel
          inherited Panel4: TPanel
            inherited FrNPoints: TFrameParInput
              inherited frPanel: TPanel
                inherited EditFrm: TEdit
                  Left = 121
                  ExplicitLeft = 121
                end
              end
            end
            inherited FrEndPoint: TFrameParInput
              inherited frPanel: TPanel
                inherited LabelUnit: TLabel
                  Width = 14
                  Caption = '%'
                  ExplicitWidth = 14
                end
                inherited BitBtnFrm: TBitBtn
                  Caption = 'Final Point'
                end
              end
            end
            inherited FrStartP: TFrameParInput
              inherited frPanel: TPanel
                inherited LabelUnit: TLabel
                  Width = 14
                  Caption = '%'
                  ExplicitWidth = 14
                end
                inherited BitBtnFrm: TBitBtn
                  Caption = 'Start Point'
                end
              end
            end
          end
        end
      end
    end
  end
end
