{*********************************************}
{  TeeGrid Software Library                   }
{  TeeBI Virtual Data class                   }
{  Copyright (c) 2016-2017 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit BI.Grid.Data;

interface

{
  TBIGridData class enables connecting any TDataItem to a TeeGrid

  Example:

  uses BI.Persist, BI.DataSource, BI.Grid.Data;
  var Customers : TDataItem;
      Data : TBIGridData;

    Customers:= TStore.Load('SQLite_Demo')['Customers'];
    Data:= TBIGridData.Create(Customers);
    TeeGrid1.Data:= Data;

  Optionally set a "Detail" to show it as sub-grid rows:

    Data.Detail:= TStore.Load('SQLite_Demo')['Orders'];

  Enable or disable column sorting (clicking Grid Header):

    Data.Sortable:= False; // default is True
}

uses
  System.Classes, System.TypInfo, System.Generics.Collections,

  Tee.Grid, Tee.Grid.Columns, Tee.Painter, Tee.Renders, Tee.Grid.Data,
  BI.Data, BI.DataSource, BI.Data.RTTI;

type
  TBIGridData=class(TVirtualData)
  private
    FCursor : TDataCursor;
    FSortable : Boolean;

    class function DataOf(const AColumn:TColumn):TDataItem; inline; static;

    function GetData: TDataItem;
    class procedure LinkTo(const AColumn: TColumn; const AItem:TDataItem); static;
    function RowOf(const ARow:Integer):Integer;
    procedure SetData(const Value: TDataItem);
    procedure SetSortable(const Value: Boolean);
  protected
    Master : TDataItem;

    procedure SetField(const AColumn:TColumn; const ASource:TObject); override;
  public
    Detail : TDataItem;

    Constructor Create(const AProvider:TDataProvider); overload;
    Constructor Create(const AItem:TDatAItem=nil); overload;

    {$IFNDEF AUTOREFCOUNT}
    Destructor Destroy; override;
    {$ENDIF}

    procedure AddColumns(const AColumns:TColumns); override;
    function AsFloat(const AColumn:TColumn; const ARow:Integer):TFloat; override;
    function AsString(const AColumn:TColumn; const ARow:Integer):String; override;
    function AutoWidth(const APainter:TPainter; const AColumn:TColumn):Single; override;

    function CanExpand(const Sender:TRender; const ARow:Integer):Boolean; override;
    function CanSortBy(const AColumn:TColumn):Boolean; override;
    class function ColumnOf(const AGrid:TCustomTeeGrid; const AItem:TDataItem):TColumn; static;

    function Count:Integer; override;

    class function From(const ASource:TComponent):TVirtualData; override;
    class function From(const AData:TDataItem):TBIGridData; overload;

    class function From<T>(const Value:Array of T):TBIGridData; overload; static;
    class function From<T>(const Value:TList<T>):TBIGridData; overload; static;

    function GetDetail(const ARow:Integer; const AColumns:TColumns; out AParent:TColumn): TVirtualData; override;

    class function IsNumeric(const AColumn:TColumn):Boolean; override;
    function IsSorted(const AColumn:TColumn; out Ascending:Boolean):Boolean; override;

    procedure Load(const AColumns:TColumns); override;
    procedure SetValue(const AColumn:TColumn; const ARow:Integer; const AText:String); override;
    procedure SortBy(const AColumn:TColumn); override;
    function DataType(const AColumn:TColumn):PTypeInfo; override;

    property Data:TDataItem read GetData write SetData;
    property Sortable:Boolean read FSortable write SetSortable default True;
  end;

implementation
