{*********************************************}
{  TeeGrid Software Library                   }
{  Themes                                     }
{  Copyright (c) 2016-2017 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit Tee.Grid.Themes;
{$I Tee.inc}

interface

{
  Small helper methods to change the formatting aspect of a TeeGrid.

  Example:

    TAndroidTheme.ApplyTo( TeeGrid1.Grid );
}

uses
  {$IFNDEF NOUITYPES}
  System.UITypes,
  {$ENDIF}

  Tee.Format, Tee.Grid.RowGroup, Tee.Grid, Tee.Grid.Columns;

type
  TDefaultTheme=record
  public
    class procedure ApplyTo(const AGroup:TRowGroup); overload; static;
    class procedure ApplyTo(const AGrid:TCustomTeeGrid); overload; static;
    class procedure CheckRenders(const AColumns:TColumns; const AColor:TColor); static;
  end;

  TBlackTheme=record
  public
    class procedure ApplyTo(const AGroup:TRowGroup); overload; static;
    class procedure ApplyTo(const AGrid:TCustomTeeGrid); overload; static;
  end;

  TiOSTheme=record
  private
  const
    TealBlue=$FAC85A;
  public
    class procedure ApplyTo(const AGroup: TRowGroup); overload; static;
    class procedure ApplyTo(const AGrid:TCustomTeeGrid); overload; static;
  end;

  TAndroidTheme=record
  public
    class procedure ApplyTo(const AGroup:TRowGroup); overload; static;
    class procedure ApplyTo(const AGrid:TCustomTeeGrid); overload; static;
  end;

  TGridThemes=record
  private
    class procedure CheckScrollBars(const AGroup:TRowGroup); static;
  public
    class var
      Default : TDefaultTheme;
      Black : TBlackTheme;
      iOS : TiOSTheme;
      Android : TAndroidTheme;
  end;

  TCustomTheme=class
  public
  type
    TThemeFont=record
    public
      Name : String;
      Size : Single;
      Color : TColor;
    end;

    THeaderTheme=record
    public
      Brush : TColor;
      Font : TColor;
    end;

  var
    Brush : TColor;
    Font : TThemeFont;
    Header : THeaderTheme;
    Hover : TColor;
    HoverFont : TColor;
    Selected : TColor;
    SelectedFont : TColor;
    Stroke : TColor;

    procedure ApplyTo(const AGroup:TRowGroup); overload;
    procedure ApplyTo(const AGrid:TCustomTeeGrid); overload;
  end;

implementation
