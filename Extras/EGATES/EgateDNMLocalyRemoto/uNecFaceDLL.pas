unit uNecFaceDLL;

interface
uses Windows,ExtCtrls;

const
  MAXFACES = 2;
  MAXMINUCIASIZE = 3000;
  NFP_SUCCESS = 1;
  NFP_FAILED = 0;
  NFP_CANNOT_FIND_FACE = 99;
  NFP_DATA_END = 88;
  NFP_NO_DATA = 10;
  NFP_FILE_OPEN_ERROR = -10011;
  NFP_FILE_READ_ERROR = -10012;
  NFP_FILE_WRITE_ERROR = -10013;
  NFP_FILE_SEEK_ERROR = -10014;
  NFP_LICENSE_ERROR = -10098;
  NFP_INTERNAL = -10099;
  NFP_FORMAT_ERROR = -10101;
  NFP_ILLEGAL_TYPE = -10102;
  NFP_ILLEGAL_DIM = -10103;
  NFP_ARGUMENT_ERROR = -10202;
  NFP_STATUS_ERROR = -10203;
  NFP_NOT_INITIALILZE_ERROR = -10301;
  NFP_FET_PARAM_ERROR = -10302;
  NFP_FET_CREATE_ERROR = -10303;
  NFP_FET_ADJUST_ERROR = -10304;
  NFP_FET_CONVERT_ERROR = -10305;
  NFP_NO_EXIST_DB_ERROR = -10306;
  NFP_PARAM_ERROR = -10307;
  NFP_ESTIMATEPOSE_ERROR = -10308;
  NFP_LOCATEEYES_ERROR = -10309;
  NFP_CORE_ERROR = -10399;
  NFP_MEMORY_ERROR = -90000;
  NFP_RECORD_BUF = 256;
  NFP_BUF_SIZE = 1024;
  NFP_ALGORITHM003 = 4;
  NFP_ALGORITHM004 = 6;
  NFP_ALGORITHM003F2EX = 10000;
  NFP_SCORE_ODERED = 1;
  NFP_DISTANCE_ODERED = 2;
  NFP_MODE_DEPTH = 2;
  NFP_MODE_TIME = 1;
  NFP_FINDFACE_NORMAL = 1;
  NFP_FINDFACE_QUICK = 2;
  NFP_LOCATEEYES_DE = 0;
  NFP_LOCATEEYES_F1 = 1;
  NFP_LOCATEEYES_F2 = 2;
  NFP_LOCATEEYES_F3 = 3;
  NFP_FLG_OFF = 0;
  NFP_FLG_ON = 1;

type
  NEO_POS = packed record
    position: TPoint;
    score: Single;
  end;



  NEO_FACEINFO =packed record
    index: Integer;
    frontalFaceScore: Single;
    faceRoll: Single;
    facePan: Single;
    faceTilt: Single;
    facialPosScore: Single;
    faceConfidence: Single;
    headConfidence: Single;
    faceScore: Single;
    headScore: Single;
    faceArea: TRect;
    headArea: TRect;
    RightEye: NEO_POS;
    LeftEye: NEO_POS;
    REyeIn: NEO_POS;
    LEyeIn: NEO_POS;
    REyeTail: NEO_POS;
    LEyeTail: NEO_POS;
    CNose: NEO_POS;
    RNose: NEO_POS;
    LNose: NEO_POS;
    TopNose: NEO_POS;
    CMouth: NEO_POS;
    RMouth: NEO_POS;
    LMouth: NEO_POS;
    TCUpperLip: NEO_POS;
    BCUpperLip: NEO_POS;
  end;


  NEO_FACESINFO =packed record
    faceNumber: Integer;
    faces: Array[0..MAXFACES-1] of NEO_FACEINFO;
  end {tagNEO_FACESINFO};

  NEO_FACEFEATURE =packed record
    face: NEO_FACEINFO;
    featureSize: Integer;
    features: Array[0..MAXMINUCIASIZE-1] of Byte;
  end {tagNEO_FACEFEATURE};

  NEO_FACEFEATURES =packed record
    faceNumber: Integer;
    features: Array[0..MAXFACES-1] of NEO_FACEFEATURE;
  end {tagNEO_FACESFEATURES};

var
  nativeInitialize: function: Integer; cdecl;
  nativeTerminate: function: Integer; cdecl;

  nativeFindOneFaceFromRaw: function(i_raw: Byte;
                       i_width: Integer;
                       i_height: Integer;
                       iAlg: Integer;
                       iDetectionMode: Integer;
                       iEyesRoll: Integer; 
                       iEyesMaxWidth: Integer; 
                       iEyesMinWidth: Integer;
                       iReliability: Single;
                       var o_FaceInfo: NEO_FACEINFO): Integer; cdecl;

  nativeFindOneFaceFromBMP: function(i_bmp: PByte;
                       iAlg: Integer;
                       iDetectionMode: Integer;
                       iEyesRoll: Integer;
                       iEyesMaxWidth: Integer;
                       iEyesMinWidth: Integer;
                       iReliability: Single;
                       var o_FaceInfo: NEO_FACEINFO): Integer; cdecl;


  nativeGetOneFaceFeatureFromRaw: function(i_raw: PByte;
                       i_width: Integer;
                       i_height: Integer; 
                       iAlg: Integer; 
                       iDetectionMode: Integer;
                       iLocateEyesType: Integer;
                       iEyesRoll: Integer;
                       iEyesMaxWidth: Integer;
                       iEyesMinWidth: Integer; 
                       iReliability: Single;
                       iType: Integer; 
                       var o_FaceInf: NEO_FACEINFO;
                       var o_fetSize: Integer;
                       var o_fet : PByte): Integer; cdecl;


  nativeGetOneFaceFeatureFromBMP: function(i_bmp:PByte;
                       iAlg: Integer; 
                       iDetectionMode: Integer;
                       iLocateEyesType: Integer; 
                       iEyesRoll: Integer; 
                       iEyesMaxWidth: Integer;
                       iEyesMinWidth: Integer; 
                       iReliability: Single;
                       iType: Integer;
                       var o_FaceInfo: NEO_FACEINFO;
                       var o_fetSize: Integer;
                       o_fet : PByte): Integer; cdecl;



  nativeFindManyFacesFromRaw: function(i_raw: PByte;
                       i_width: Integer;
                       i_height: Integer; 
                       iAlg: Integer; 
                       iDetectionMode: Integer;
                       iEyesRoll: Integer; 
                       iEyesMaxWidth: Integer;
                       iEyesMinWidth: Integer; 
                       iReliability: Single;
                       var o_MFaceInfo: NEO_FACESINFO): Integer; cdecl;


  nativeFindManyFacesFromBMP: function(i_bmp: PByte;
                       iAlg: Integer;
                       iDetectionMode: Integer;
                       iEyesRoll: Integer; 
                       iEyesMaxWidth: Integer; 
                       iEyesMinWidth: Integer;
                       iReliability: Single;
                       var o_MFaceInfo: NEO_FACESINFO): Integer; cdecl;


  nativeGetManyFaceFeaturesFromRaw: function(i_raw: PByte;//BYTE;
                       i_width: Integer;
                       i_height: Integer; 
                       iAlg: Integer;
                       iDetectionMode: Integer;
                       iLocateEyesType: Integer;
                       iEyesRoll: Integer;
                       iEyesMaxWidth: Integer; 
                       iEyesMinWidth: Integer;
                       iReliability: Single;
                       iType: Integer; 
                       var o_f: NEO_FACEFEATURES): Integer; cdecl;


  nativeGetManyFaceFeaturesFromBMP: function(i_bmp: PByte;
                       iAlg: Integer;
                       iDetectionMode: Integer;
                       iLocateEyesType: Integer;
                       iEyesRoll: Integer;
                       iEyesMaxWidth: Integer;
                       iEyesMinWidth: Integer;
                       iReliability: Single;
                       iType: Integer;
                       var o_features: NEO_FACEFEATURES): Integer; cdecl;

  nativeVerify: function(i_query_fet: PByte;
                       i_queryFetSize: Integer;
                       i_target_fet: PByte;
                       i_targetFetSize: Integer;
                       var score: Single): Integer; cdecl		;


  function cargarDllNecFace:Boolean;
  Procedure destruirDllNecFace;


  function ProcesoFoto1(Img:TImage):Boolean;
  function ProcesoFoto2(Img:TImage):Boolean;
  procedure pintoOjosFoto1(Img:TImage);
  procedure pintoOjosFoto2(Img:TImage);
  function Fotoscore:Single;

  function BuscoCara(archivoBMP:string):Boolean;
  procedure escribirErrorArchivo(Mensaje: string);

  function ConvertirFotoAMinusia(archivoJPG,archivoMin:AnsiString):Integer;
  function ConvertirFotoBmpAMinusia(DirPath,archivoBmp,archivoMin:AnsiString):Integer;
  function ArchFotoscore(ArchMin1,ArchMin2:AnsiString):Single;

  function dirTmpImg:String;



Var
  gNecFace_Error :String = '';



implementation

uses SysUtils, Classes, Math, Graphics, jpeg, dialogs,IniFiles,EgateFunciones;


var
  DLLHandle: THandle=0;

  minutia1:PByte;featureSize1:Integer;
  minutia2:PByte;featureSize2:Integer;
  facefeature1,facefeature2:NEO_FACEFEATURE;
  TamW,TamH:Integer;



  glb_NEC_FACE_SICAM_PORC_MIN_ID_POSITIVA : Integer;
  glb_NEC_FACE_SICAM_PORC_MAX_ID_DUBITADA : Integer;


  glb_NEC_FACE_Alg : Integer;
  glb_NEC_FACE_DetectionMode  : Integer;
  glb_NEC_FACE_EyesRoll : Integer;
  glb_NEC_FACE_EyesMaxWidth : Integer;
  glb_NEC_FACE_EyesMinWidth : Integer;
  glb_NEC_FACE_Reliability : Double;
  glb_NEC_FACE_o_fetSize : Integer;
  glb_NEC_FACE_Type : Integer;
  glb_NEC_FACE_LocateEyesType  : Integer;


function dirTmpImg:string;
var
  dir:String;
begin
  //dir := GetEnvironmentVariable('UserProfile')+'\TempImages\';
  dir := 'C:\TempNecFace64\';

  //dir := GetEnvironmentVariable('UserProfile')+'\TempImages\';
  Result := dir;
end;


procedure escribirErrorArchivo(Mensaje: string);
var
  archivo: TStringList;
  archivo_errores: string;
begin
  Exit;

  try
    archivo_errores := ExtractFilePath(ParamStr(0)) + '\log\error.log';

    archivo := TStringList.Create;
    if FileExists(archivo_errores) then
      archivo.LoadFromFile(archivo_errores);

    Mensaje :=  FormatDateTime('mm-dd-yyyy hh:nn:ss', SysUtils.Now) + ' - ' + mensaje;
    archivo.Text := mensaje + #13#10 + archivo.Text;
    archivo.SaveToFile(archivo_errores);
    archivo.Free;
  except
  end;
end;


function cargarDllNecFace:Boolean;
var
  iRet:Integer;
begin
//  if DLLHandle=0 then Exit;

  if not FaceComp then
  begin
    DLLHandle:=0;
    Exit;
  end;





  // Agragado por NECAR.  Se deactivan excepciones FPU
  try
    gNecFace_Error := 'NecFace error. No esta la DLL';
    System.Set8087CW($133f);
//    if FileExists('C:\NECFACE64\NEOFaceCWrapper.dll') then
//      DLLHandle := LoadLibrary('C:\NECFACE64\NEOFaceCWrapper.dll')
//    else
    DLLHandle := LoadLibrary('NEOFaceCWrapper.dll');
    if DLLHandle<32 then
      raise Exception.Create(gNecFace_Error);


    @nativeInitialize := GetProcAddress(DLLHandle,'nativeInitialize');
    @nativeTerminate := GetProcAddress(DLLHandle,'nativeTerminate');
    @nativeFindOneFaceFromRaw := GetProcAddress(DLLHandle,'nativeFindOneFaceFromRaw');
    @nativeFindOneFaceFromBMP := GetProcAddress(DLLHandle,'nativeFindOneFaceFromBMP');
    @nativeGetOneFaceFeatureFromRaw := GetProcAddress(DLLHandle,'nativeGetOneFaceFeatureFromRaw');
    @nativeGetOneFaceFeatureFromBMP := GetProcAddress(DLLHandle,'nativeGetOneFaceFeatureFromBMP');
    @nativeFindManyFacesFromRaw := GetProcAddress(DLLHandle,'nativeFindManyFacesFromRaw');
    @nativeFindManyFacesFromBMP := GetProcAddress(DLLHandle,'nativeFindManyFacesFromBMP');
    @nativeGetManyFaceFeaturesFromRaw := GetProcAddress(DLLHandle,'nativeGetManyFaceFeaturesFromRaw');
    @nativeGetManyFaceFeaturesFromBMP := GetProcAddress(DLLHandle,'nativeGetManyFaceFeaturesFromBMP');
    @nativeVerify := GetProcAddress(DLLHandle,'nativeVerify');


    iRet := nativeInitialize();
    if(iRet <> NFP_SUCCESS) then
    begin
      gNecFace_Error := 'NecFace error. - Cod:'+(IntToStr(iRet))+' - Se desactiva la comprobación de NECFACE';
      raise Exception.Create(gNecFace_Error);
    end;
    Result := True;
  except
    on e:exception do
    begin
      escribirErrorArchivo(e.Message);
      Result := False;
    end;
  end;

end;

Procedure destruirDllNecFace;
begin
  if DLLHandle=0 then Exit;

  nativeTerminate();
  FreeLibrary(DLLHandle);
end;

//------------------------------------------------------------------------------------------------------------


procedure DrawEllipseFromCenter(Canvas: TCanvas; CenterOfEllipse: TPoint; RadiusOfCircle: Integer);
var
  R: TRect;
begin
  with Canvas do begin
    Brush.Style := bsClear;
    Pen.Color := clGreen;
    Pen.Style := psSolid;
    Pen.Width := 2;
    R.Top := CenterOfEllipse.Y - RadiusOfCircle;
    R.Left := CenterOfEllipse.X - RadiusOfCircle;
    R.Bottom := CenterOfEllipse.Y + RadiusOfCircle;
    R.Right := CenterOfEllipse.X + RadiusOfCircle;
    Ellipse(R);
    MoveTo(CenterOfEllipse.X, CenterOfEllipse.Y);
    LineTo(CenterOfEllipse.X, CenterOfEllipse.Y);
  end;
end;

procedure DrawRectangle(Canvas: TCanvas; FStart,FEnd:TPoint);
begin
  with Canvas do begin
    Brush.Style := bsClear;
    Pen.Color := clGreen;
    Pen.Style := psSolid;
    Pen.Width := 3;
    Rectangle(FStart.X, FStart.Y, FEnd.X, FEnd.Y);
  end;
end;


procedure LoadImg(name:AnsiString;var i_img:PByte;size:Integer);
var
  FS :TFileStream;
begin
  FS := TFileStream.Create(name,fmOpenRead);
  try
    FS.Read(i_img^,size);
  finally
    FS.Free;
  end;
end;


procedure ResizeBitmap(Bitmap: TBitmap; Width, Height: Integer; Background: TColor);
var
  R: TRect;
  B: TBitmap;
  X, Y: Integer;
begin
  if assigned(Bitmap) then begin
    B:= TBitmap.Create;
    try
      if Bitmap.Width > Bitmap.Height then begin
        R.Right:= Width;
        R.Bottom:= ((Width * Bitmap.Height) div Bitmap.Width);
        X:= 0;
        Y:= (Height div 2) - (R.Bottom div 2);
      end else begin
        R.Right:= ((Height * Bitmap.Width) div Bitmap.Height);
        R.Bottom:= Height;
        X:= (Width div 2) - (R.Right div 2);
        Y:= 0;
      end;
      R.Left:= 0;
      R.Top:= 0;
      B.PixelFormat:= pf24bit;
      B.Width:= Width;
      B.Height:= Height;
      B.Canvas.Brush.Color:= Background;
      B.Canvas.FillRect(B.Canvas.ClipRect);
      B.Canvas.StretchDraw(R, Bitmap);
      Bitmap.PixelFormat:= pf24bit;
      Bitmap.Width:= Width;
      Bitmap.Height:= Height;
      Bitmap.Canvas.Brush.Color:= Background;
      Bitmap.Canvas.FillRect(Bitmap.Canvas.ClipRect);
      Bitmap.Canvas.Draw(X, Y, B);
    finally
      B.Free;
    end;
  end;
end;


function ConvertbitmapTo24bits(Original: Tbitmap): TBitmap;
var
  Arect: Trect;
begin
   Result := Tbitmap.Create;
   Result.PixelFormat := pf24bit;
   Result.width := Original.Width;
   Result.Height := Original.Height;
   ARect := rect(0, 0, Original.Width, Original.Height);
    Result.Canvas.CopyRect(ARect, Original.Canvas, ARect);
end;

function ProcesoFoto(Img:TImage;var minutia:PByte;var featureSize:Integer;var facefeature:NEO_FACEFEATURE;orden:Integer;dirPath:String):Integer;
var
  strBmp:String;
  i_bmp:PByte;
  i_width_Face,i_height_Face, iRet : Integer;
  o_features:NEO_FACEFEATURES;
  bmp2,bmp24 :TBitmap;

begin
  Randomize;

  strBmp := dirPath+'F'+IntToStr(RandomRange(1000,99999999))+'.bmp';

  //-----------------------
  Img.Picture.Bitmap.pixelformat:=pf24bit;
  //bmp24 := ConvertbitmapTo24bits(img.Picture.Bitmap);

  //if (orden=1) then
  //begin
  //  TamW := Img.Picture.Width;
  //  TamH := Img.Picture.Height;
  //end else begin
  //  Img.Picture.Bitmap.Width := TamW;
  //  Img.Picture.Bitmap.Height := TamH;
  //  Img.Picture.Bitmap.pixelformat:=pf24bit;
  //end;
  //----------------------
  //bmp24.SaveToFile(strBmp);
  Img.Picture.Bitmap.SaveToFile(strBmp);

  //Img.Picture.Bitmap.SaveToFile(ParamStr(2));
  //ShowMessage(strBmp);
  try
    i_width_Face := Img.Picture.Bitmap.Width;
	  i_height_Face := Img.Picture.Bitmap.Height;


    GetMem(i_bmp,((i_width_Face*i_height_Face) * 3) + 54);

    LoadImg(strBmp, i_bmp, (((i_width_Face*i_height_Face) * 3) + 54));


	  iRet := nativeGetManyFaceFeaturesFromBMP(i_bmp,glb_NEC_FACE_Alg,glb_NEC_FACE_DetectionMode,glb_NEC_FACE_LocateEyesType,glb_NEC_FACE_EyesRoll,glb_NEC_FACE_EyesMaxWidth,
	       glb_NEC_FACE_EyesMinWidth,glb_NEC_FACE_Reliability,glb_NEC_FACE_Type,o_features);

    Result := iRet;

    if(iRet <> NFP_SUCCESS) then
    begin
      Exit;
    end;


    if Assigned(minutia) then
      FreeMem(minutia);

    minutia := nil;

    if o_features.faceNumber<>1 then
    begin
      Result := NFP_CANNOT_FIND_FACE;
      Exit;
    end;

    GetMem(minutia,o_features.features[0].featureSize);

    CopyMemory(minutia, @o_features.features[0].features,o_features.features[0].featureSize);

    featureSize := o_features.features[0].featureSize;

    facefeature := o_features.features[0];

  finally
    DeleteFile(strBmp);
    FreeMem(i_bmp);
  end;
end;



function BuscoCara(archivoBMP:string):Boolean;
var
  strBmp:String;
  Img:TImage;
  nH,nW:Integer;
  i_bmp:PByte;
  i_width_Face,i_height_Face, iRet,DeltaY,DeltaX : Integer;
  o_features:NEO_FACEFEATURES;
  bmp2 :TBitmap;
  o_FaceInfo: NEO_FACEINFO;
  aux : TJPEGImage;
begin
  img:= TImage.Create(nil);
  try
    Img.Picture.Bitmap.LoadFromFile(archivoBMP);

    nW := Img.Picture.Bitmap.Width;
    nH := Img.Picture.Bitmap.Height;

    if (nW mod 4)<>0 then
    begin
      nW := nW + (nW mod 4);
    end;

    ResizeBitmap(Img.Picture.Bitmap,nW,nH,clWhite);

    try
      i_width_Face := Img.Picture.Width;
      i_height_Face := Img.Picture.Height;


      GetMem(i_bmp,((i_width_Face*i_height_Face) * 3) + 54);

      LoadImg(archivoBMP, i_bmp, (((i_width_Face*i_height_Face) * 3) + 54));

      iRet := nativeFindOneFaceFromBMP(i_bmp,
                  glb_NEC_FACE_Alg,
                  glb_NEC_FACE_DetectionMode,
                  glb_NEC_FACE_EyesRoll,
                  glb_NEC_FACE_EyesMaxWidth,
                  glb_NEC_FACE_EyesMinWidth,
                  glb_NEC_FACE_Reliability,o_FaceInfo);

      if(iRet <> NFP_SUCCESS) then
      begin
        Result := False;
        Exit;
      end;
      Result := True;
    except
      Result := False;
    end;
  finally
    Img.Free;
  end;
end;



function ProcesoFoto1(Img:TImage):Boolean;
begin
  if Not Assigned(Img.Picture.Bitmap) then
  begin
    Result := False;
    Exit;
  end;

  try
    Result := ProcesoFoto(Img,minutia1,featureSize1,facefeature1,0,'')=NFP_SUCCESS;
  except
    Result := False;
  end;
end;

function ConvertirFotoBmpAMinusia(DirPath,archivoBmp,archivoMin:AnsiString):Integer;
var
  bmp:TBitmap;
  Img:TImage;
  minutia:PByte;featureSize:Integer;
  facefeature:NEO_FACEFEATURE;
  strFile : TFileStream;
  nH,nW:Integer;
  I: Integer;
begin
  img:= TImage.Create(nil);
  try

    Img.Picture.Bitmap.LoadFromFile(archivoBmp);

    nW := Img.Picture.Bitmap.Width;
    nH := Img.Picture.Bitmap.Height;

    if (nW mod 4)<>0 then
    begin
      nW := nW + (nW mod 4);
    end;

    ResizeBitmap(Img.Picture.Bitmap,nW,nH,clWhite);

    minutia := nil;

    Result := ProcesoFoto(Img,minutia,featureSize,facefeature,1,DirPath);

    if result=NFP_FILE_READ_ERROR then begin
      Img.Picture.Bitmap.LoadFromFile(archivoBmp);

      nW := Img.Picture.Bitmap.Width;
      nH := Img.Picture.Bitmap.Height;

      if (nW mod 4)<>0 then
      begin
        nW := nW - (nW mod 4);
      end;

      ResizeBitmap(Img.Picture.Bitmap,nW,nH,clWhite);

      minutia := nil;

      Result := ProcesoFoto(Img,minutia,featureSize,facefeature,1,DirPath);
    end;



    if featureSize>0 then
    begin
      strFile := TFileStream.Create(archivoMin, fmCreate);
      try
        strFile.Write(minutia^,featureSize);
      finally
        strFile.free;
      end;
    end;
  finally
    Img.Free;
  end;

end;

function ConvertirFotoAMinusia(archivoJPG,archivoMin:AnsiString):Integer;
var
  jpg:TJPEGImage;
  bmp:TBitmap;
  img:TImage;
  minutia:PByte;featureSize:Integer;
  facefeature:NEO_FACEFEATURE;
  strFile : TFileStream;
begin
  jpg:= TJPEGImage.create;
  bmp:=TBitmap.Create;
  try
    jpg.LoadFromFile(archivoJPG);
    bmp.Assign(jpg);
    img:= TImage.Create(nil);
    img.Picture.Assign(bmp);
  finally
    jpg.Free;
    bmp.Free;
  end;
  minutia := nil;

  //ShowMessage(archivoJPG);

  Result := ProcesoFoto(Img,minutia,featureSize,facefeature,1,'');

  //ShowMessage('1');

  strFile := TFileStream.Create(archivoMin, fmCreate);
  try
    strFile.Write(minutia^,featureSize);
  finally
    strFile.free;
  end;

  img.free;
end;

function GetFileData(Filename: String; var FileLength: Integer): PByte;
var
  f: Integer;
begin
  Result := nil;
  f := FileOpen(Filename, fmOpenRead);
  if f <> -1 then
  begin
    FileLength := FileSeek(f, 0, 2);
    FileSeek(f, 0, 0);
    GetMem(Result, FileLength);
    FillChar(Result^, FileLength, 0);
    FileRead(f, Result^, FileLength);
    FileClose(f);
  end;
end;


function ArchFotoscore(ArchMin1,ArchMin2:AnsiString):Single;
var
  score : Single;
  iRet:Integer;
  Local_minutia1:PByte;Local_featureSize1:Integer;
  Local_minutia2:PByte;Local_featureSize2:Integer;

begin
  score := 0;
  Result := 0;

  Local_minutia1 := GetFileData(ArchMin1,Local_featureSize1);
  Local_minutia2 := GetFileData(ArchMin2,Local_featureSize2);

  try
    iRet := nativeVerify(Local_minutia1,Local_featureSize1,Local_minutia2,Local_featureSize2,score);

    if(iRet <> NFP_SUCCESS) then
    begin
      raise Exception.Create('Error NecFace:'+IntToStr(iRet));
    end;
    Result := score*100;
  except
  end;
  FreeMem(Local_minutia1);
  FreeMem(Local_minutia2);
end;






function ProcesoFoto2(Img:TImage):Boolean;
begin
  if Not Assigned(Img.Picture.Bitmap) then
  begin
    Result := False;
    Exit;
  end;

  try
    Result := ProcesoFoto(Img,minutia2,featureSize2,facefeature2,2,'')=NFP_SUCCESS;
  except
    Result := False;
  end;
end;


procedure pintoOjos(Canvas: TCanvas;var facefeature:NEO_FACEFEATURE);
begin
    DrawEllipseFromCenter(Canvas,facefeature.face.RightEye.position,5);
    DrawEllipseFromCenter(Canvas,facefeature.face.LeftEye.position,5);
    DrawRectangle(Canvas,facefeature.face.faceArea.TopLeft,facefeature.face.faceArea.BottomRight);
    DrawEllipseFromCenter(Canvas,facefeature.face.RMouth.position,5);
    DrawEllipseFromCenter(Canvas,facefeature.face.LMouth.position,5);
    DrawEllipseFromCenter(Canvas,facefeature.face.CMouth.position,5);
end;

procedure pintoOjosFoto1(Img:TImage);
begin
  pintoOjos(Img.Canvas,facefeature1);
end;

procedure pintoOjosFoto2(Img:TImage);
begin
  pintoOjos(Img.Canvas,facefeature2);
end;

function Fotoscore:Single;
var
  score : Single;
  iRet:Integer;
begin
  score := 0;
  Result := 0;

  try
    iRet := nativeVerify(minutia1,featureSize1,minutia2,featureSize2,score);
    if(iRet <> NFP_SUCCESS) then
    begin
      raise Exception.Create('Error NecFace:'+IntToStr(iRet));
    end;
    Result := score;
  except
  end;
end;

const
  NEC_FACE_key = 'NEC_FACE';

     NEC_FACE_subkey_SICAM_PORC_MIN_ID_POSITIVA = 'SICAM_PORC_MIN_ID_POSITIVA';
     NEC_FACE_subkey_SICAM_PORC_MAX_ID_DUBITADA = 'SICAM_PORC_MAX_ID_DUBITADA';

     NEC_FACE_subkey_Alg = 'Alg';
     NEC_FACE_subkey_DetectionMode = 'DetectionMode';
     NEC_FACE_subkey_EyesRoll = 'EyesRoll';
     NEC_FACE_subkey_EyesMaxWidth = 'EyesMaxWidth';
     NEC_FACE_subkey_EyesMinWidth = 'EyesMinWidth';
     NEC_FACE_subkey_Reliability = 'Reliability';
     NEC_FACE_subkey_o_fetSize  = 'o_fetSize';
     NEC_FACE_subkey_Type  = 'Type';
     NEC_FACE_subkey_LocateEyesType  = 'LocateEyesType';


  function LeerIniString(reg : TIniFile;Sec, Key, def : string) : String;
  begin
    result :=reg.ReadString(Sec,Key,def);
  end;

var
  Ini:TIniFile;


initialization
  FormatSettings.DecimalSeparator := ',';

  Randomize;

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\config.ini');
  try
    glb_NEC_FACE_SICAM_PORC_MIN_ID_POSITIVA := STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_SICAM_PORC_MIN_ID_POSITIVA,'70'));
    glb_NEC_FACE_SICAM_PORC_MAX_ID_DUBITADA := STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_SICAM_PORC_MAX_ID_DUBITADA,'80'));

    glb_NEC_FACE_Alg := STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_Alg,'10000'));
    glb_NEC_FACE_DetectionMode := STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_DetectionMode,'1'));
    glb_NEC_FACE_EyesRoll:= STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_EyesRoll,'15'));
    glb_NEC_FACE_EyesMaxWidth := STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_EyesMaxWidth,'240'));
    glb_NEC_FACE_EyesMinWidth:= STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_EyesMinWidth,'80'));
    glb_NEC_FACE_Reliability := StrToFloat(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_Reliability,'0,8'));
    glb_NEC_FACE_o_fetSize:= STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_o_fetSize,'0'));
    glb_NEC_FACE_Type:= STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_Type,'0'));
    glb_NEC_FACE_LocateEyesType:= STRTOINT(LeerIniString(Ini,NEC_FACE_key,NEC_FACE_subkey_LocateEyesType,'14'));
  finally
    Ini.Free;
  end;

  cargarDllNecFace;

finalization
  destruirDllNecFace;

end.
