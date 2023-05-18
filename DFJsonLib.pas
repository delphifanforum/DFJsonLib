unit DFJsonLib;

interface

uses
  System.JSON, System.DateUtils;

type
  TDFJsonLib = class
  public
    class function Parse(const AJson: string): TJSONObject;
    class function CreateObject: TJSONObject;
    class function CreateArray: TJSONArray;
    class procedure AddPair(AObject: TJSONObject; const AName: string; const AValue: TJSONValue);
    class procedure AddElement(AArray: TJSONArray; const AValue: TJSONValue);
    class function Query(AJson: TJSONObject; const AQuery: string): TJSONValue;
    class function Validate(AJson: TJSONObject; ASchema: TJSONObject): Boolean;
    class function Serialize(AJson: TJSONObject): string;
    class function Deserialize(const AJson: string): TJSONObject;
    class function GetArraySize(AArray: TJSONArray): Integer;
    class function GetArrayElement(AArray: TJSONArray; AIndex: Integer): TJSONValue;
    class function GetObjectProperty(AObject: TJSONObject; const AName: string): TJSONValue;
    class procedure SetObjectProperty(AObject: TJSONObject; const AName: string; const AValue: TJSONValue);
    class procedure RemoveObjectProperty(AObject: TJSONObject; const AName: string);
    class function GetBooleanValue(AValue: TJSONValue): Boolean;
    class function GetIntegerValue(AValue: TJSONValue): Integer;
    class function GetStringValue(AValue: TJSONValue): string;
    class function GetFloatValue(AValue: TJSONValue): Double;
    class function GetDateTimeValue(AValue: TJSONValue): TDateTime;
  end;

implementation

class function TDFJsonLib.Parse(const AJson: string): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
end;

class function TDFJsonLib.CreateObject: TJSONObject;
begin
  Result := TJSONObject.Create;
end;

class function TDFJsonLib.CreateArray: TJSONArray;
begin
  Result := TJSONArray.Create;
end;

class procedure TDFJsonLib.AddPair(AObject: TJSONObject; const AName: string; const AValue: TJSONValue);
begin
  AObject.AddPair(AName, AValue);
end;

class procedure TDFJsonLib.AddElement(AArray: TJSONArray; const AValue: TJSONValue);
begin
  AArray.AddElement(AValue);
end;

class function TDFJsonLib.Query(AJson: TJSONObject; const AQuery: string): TJSONValue;
begin
  Result := AJson.FindValue(AQuery);
end;

class function TDFJsonLib.Validate(AJson: TJSONObject; ASchema: TJSONObject): Boolean;
var
  Validator: TJSONValidator;
begin
  Validator := TJSONValidator.Create(ASchema);
  try
    Result := Validator.Validate(AJson);
  finally
    Validator.Free;
  end;
end;

class function TDFJsonLib.Serialize(AJson: TJSONObject): string;
begin
  Result := AJson.ToJSON;
end;

class function TDFJsonLib.Deserialize(const AJson: string): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
end;

class function TDFJsonLib.GetArraySize(AArray: TJSONArray): Integer;
begin
  Result := AArray.Count;
end;

class function TDFJsonLib.GetArrayElement(AArray: TJSONArray; AIndex: Integer): TJSONValue;
begin
  Result := AArray.Items[AIndex];
end;

class function TDFJsonLib.GetObjectProperty(AObject: TJSONObject; const AName: string): TJSONValue;
begin
  Result := AObject.GetValue(AName);
end;

class procedure TDFJsonLib.SetObjectProperty(AObject: TJSONObject; const AName: string; const AValue: TJSONValue);
begin
  AObject.AddPair(AName, AValueend;

class procedure TDFJsonLib.RemoveObjectProperty(AObject: TJSONObject; const AName: string);
begin
  AObject.RemovePair(AName);
end;

class function TDFJsonLib.GetBooleanValue(AValue: TJSONValue): Boolean;
begin
  Result := AValue.GetValue<Boolean>;
end;

class function TDFJsonLib.GetIntegerValue(AValue: TJSONValue): Integer;
begin
  Result := AValue.GetValue<Integer>;
end;

class function TDFJsonLib.GetStringValue(AValue: TJSONValue): string;
begin
  Result := AValue.GetValue<string>;
end;

class function TDFJsonLib.GetFloatValue(AValue: TJSONValue): Double;
begin
  Result := AValue.GetValue<Double>;
end;

class function TDFJsonLib.GetDateTimeValue(AValue: TJSONValue): TDateTime;
begin
  Result := ISO8601ToDate(AValue.GetValue<string>);
end;

end.
