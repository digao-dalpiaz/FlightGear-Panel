unit UDataProcess;

interface

uses UPropertyList, System.Classes;

type
  TDataProcess = class
  public
    procedure ReceiveData(const Data: string; L: TPropertyList);
  private
    procedure ReceiveGroup(GObj: TPropertyListGroup; S: TStringList; var Index: Integer);
  end;

implementation

uses System.SysUtils, System.Rtti, System.Generics.Collections;

procedure TDataProcess.ReceiveData(const Data: string; L: TPropertyList);
var
  S: TStringList;
  Index: Integer;
begin
  Index := 0;

  S := TStringList.Create;
  try
    S.Text := Data.Replace(#9, #13#10);

    ReceiveGroup(L, S, Index);
  finally
    S.Free;
  end;
end;

function XMLStrToBoolean(const Value: string): Boolean;
begin
  if Value.IsEmpty then Result := False else
  if Value='true' then Result := True else
  if Value='false' then Result := False else
    raise Exception.Create('Invalid boolean value');
end;

procedure TDataProcess.ReceiveGroup(GObj: TPropertyListGroup; S: TStringList; var Index: Integer);
var
  _Context: TRttiContext;
  F: TRttiField;
  ValueStr: string;
  ValueTyped: TValue;
  Obj: TObject;
  ObjItem: TPropertyListGroup;
  ObjClass: TPropertyListGroupClass;
  Attr: ChunkAttribute;
  GenericList: TObjectList<TPropertyListGroup>;
  I: Integer;
begin
  for F in _Context.GetType(GObj.ClassType).GetFields do
  begin
    try
      if F.FieldType.TypeKind=tkClass then
      begin
        Obj := F.GetValue(GObj).AsObject;
        Attr := GetChunkAttribute(F);
        if Attr.IsList then
        begin
          ObjClass := RttiTypeToGroupClass(GetObjectListItemsClass(F));
          GenericList := TObjectList<TPropertyListGroup>(Obj);
          for I := 0 to Attr.ListItems-1 do
          begin
            ObjItem := TPropertyListGroup(ObjClass.NewInstance);
            GenericList.Add(ObjItem);
            ReceiveGroup(ObjItem, S, Index);
          end;
        end else
          ReceiveGroup(TPropertyListGroup(Obj), S, Index);
      end else
      begin
        ValueStr := S[Index]; Inc(Index);
        case F.FieldType.TypeKind of
          tkUString: ValueTyped := ValueStr;
          tkEnumeration: ValueTyped := XMLStrToBoolean(ValueStr);
          tkFloat: ValueTyped := StrToFloat(ValueStr, TFormatSettings.Invariant);
          else raise Exception.CreateFmt('Invalid FieldType "%s"', [F.FieldType.ToString]);
        end;
        F.SetValue(GObj, ValueTyped);
      end;
    except
      on E: Exception do
        raise Exception.CreateFmt('Error on field "%s": %s', [F.Name, E.Message]);
    end;
  end;
end;

end.
