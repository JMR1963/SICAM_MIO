// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://server-llamador/ws/manager.asmx?WSDL
//  >Import : http://server-llamador/ws/manager.asmx?WSDL>0
// Encoding : utf-8
// Version  : 1.0
// (03/02/2021 12:19:14 - - $Rev: 69934 $)
// ************************************************************************ //

unit manager;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  FileNode             = class;                 { "http://tempuri.org/"[GblCplx] }
  QueuesGroups         = class;                 { "http://tempuri.org/"[GblCplx] }
  ProductsCategories   = class;                 { "http://tempuri.org/"[GblCplx] }
  SurveysQuestions     = class;                 { "http://tempuri.org/"[GblCplx] }
  LanguagesResources   = class;                 { "http://tempuri.org/"[GblCplx] }
  ProductsPositionsRelations = class;           { "http://tempuri.org/"[GblCplx] }
  Queues               = class;                 { "http://tempuri.org/"[GblCplx] }
  ProductsPositions    = class;                 { "http://tempuri.org/"[GblCplx] }
  Channels             = class;                 { "http://tempuri.org/"[GblCplx] }
  ChannelsCameras      = class;                 { "http://tempuri.org/"[GblCplx] }
  SurveysAnswers       = class;                 { "http://tempuri.org/"[GblCplx] }
  Users                = class;                 { "http://tempuri.org/"[GblCplx] }
  Products             = class;                 { "http://tempuri.org/"[GblCplx] }
  QueuesShifts         = class;                 { "http://tempuri.org/"[GblCplx] }
  PlayersGroups        = class;                 { "http://tempuri.org/"[GblCplx] }
  PlayersDesigns       = class;                 { "http://tempuri.org/"[GblCplx] }
  LicenseEntity        = class;                 { "http://tempuri.org/"[GblCplx] }
  Surveys              = class;                 { "http://tempuri.org/"[GblCplx] }
  Players              = class;                 { "http://tempuri.org/"[GblCplx] }
  TecnoSignageLicense  = class;                 { "http://tempuri.org/"[GblCplx] }
  PlayersTimeLine      = class;                 { "http://tempuri.org/"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://tempuri.org/"[GblSmpl] }
  QUEUE_PRIORITY = (NORMAL, SILVER, GOLD, BLACK, VIP);

  { "http://tempuri.org/"[GblSmpl] }
  CATEGORY_TYPES = (FRAGANCE, FOOD, ELECTRONIC, COMPUTERS, HARDWARE, SOFTWARE, SERVICES, MOBILE, OTHERS);

  { "http://tempuri.org/"[GblSmpl] }
  ACCESS_LEVEL = (
      NONE, 
      VALIDATED, 
      CUSTOMER, 
      QUEUE_OPERATOR, 
      PROFESSIONAL, 
      PROFESSIONAL_OPERATOR, 
      MARKETING, 
      ADMIN_STATISTICS, 
      ADMIN_QUEUE, 
      ADMIN_VIEW, 
      ADMIN
  );

  { "http://tempuri.org/"[GblSmpl] }
  CHANNEL_CAMERA_TYPE = (
      AXIS_2460, 
      AXIS_2100, 
      AXIS_2110, 
      AXIS_2120, 
      AXIS_2130, 
      AXIS_205, 
      AXIS_206, 
      AXIS_2400, 
      AXIS_2401, 
      DLINK, 
      JPEG_STREAM, 
      CAMERA_LOCAL, 
      MJPEG_STREAM, 
      PANASONIC, 
      PIXORD, 
      STARDOT, 
      STARTDOT_6, 
      VIDEO_STREAM
  );

  { "http://tempuri.org/"[GblSmpl] }
  CHANNEL_TYPE = (
      IMAGES, 
      VIDEOS, 
      DOCUMENTS, 
      RSS, 
      SURVEY, 
      VIRTUAL_REALITY, 
      GAMES, 
      CAMERA, 
      TV, 
      REMOTE, 
      QUEUE, 
      TV_INTERNET, 
      SIMPLES, 
      DESIGNS, 
      PRODUCTS
  );

  { "http://tempuri.org/"[GblSmpl] }
  PlayersLogType = (INFO, ERROR, SYNC, OTHER);

  { "http://tempuri.org/"[GblSmpl] }
  LicenseTypes = (Unknown, Single_, Volume);

  { "http://tempuri.org/"[GblSmpl] }
  SCREEN_SAVER_TYPE = (NONE, ALL, INDIVIDUAL);

  { "http://tempuri.org/"[GblSmpl] }
  EQUIPMENT_TYPE = (PLAYER, TOTEM, CALLER);

  { "http://tempuri.org/"[GblSmpl] }
  LicenseTypesTecnoSignage = (FREE, STARTER, PREMIUM, ELITE);

  {$SCOPEDENUMS OFF}

  ArrayOfLanguagesResources = array of LanguagesResources;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfString = array of string;              { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : FileNode, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  FileNode = class(TRemotable)
  private
    Fpath: string;
    Fpath_Specified: boolean;
    FMD5: string;
    FMD5_Specified: boolean;
    procedure Setpath(Index: Integer; const Astring: string);
    function  path_Specified(Index: Integer): boolean;
    procedure SetMD5(Index: Integer; const Astring: string);
    function  MD5_Specified(Index: Integer): boolean;
  published
    property path: string  Index (IS_OPTN) read Fpath write Setpath stored path_Specified;
    property MD5:  string  Index (IS_OPTN) read FMD5 write SetMD5 stored MD5_Specified;
  end;



  // ************************************************************************ //
  // XML       : QueuesGroups, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  QueuesGroups = class(TRemotable)
  private
    FidQueueGroup: string;
    FidQueueGroup_Specified: boolean;
    FidParent: string;
    FidParent_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    procedure SetidQueueGroup(Index: Integer; const Astring: string);
    function  idQueueGroup_Specified(Index: Integer): boolean;
    procedure SetidParent(Index: Integer; const Astring: string);
    function  idParent_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
  published
    property idQueueGroup: string  Index (IS_OPTN) read FidQueueGroup write SetidQueueGroup stored idQueueGroup_Specified;
    property idParent:     string  Index (IS_OPTN) read FidParent write SetidParent stored idParent_Specified;
    property name_:        string  Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
  end;



  // ************************************************************************ //
  // XML       : ProductsCategories, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsCategories = class(TRemotable)
  private
    FidProductCategory: string;
    FidProductCategory_Specified: boolean;
    FidParent: string;
    FidParent_Specified: boolean;
    Ftitle: string;
    Ftitle_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    FisActive: Boolean;
    FcategoryType: CATEGORY_TYPES;
    procedure SetidProductCategory(Index: Integer; const Astring: string);
    function  idProductCategory_Specified(Index: Integer): boolean;
    procedure SetidParent(Index: Integer; const Astring: string);
    function  idParent_Specified(Index: Integer): boolean;
    procedure Settitle(Index: Integer; const Astring: string);
    function  title_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
  published
    property idProductCategory: string          Index (IS_OPTN) read FidProductCategory write SetidProductCategory stored idProductCategory_Specified;
    property idParent:          string          Index (IS_OPTN) read FidParent write SetidParent stored idParent_Specified;
    property title:             string          Index (IS_OPTN) read Ftitle write Settitle stored title_Specified;
    property description:       string          Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property isActive:          Boolean         read FisActive write FisActive;
    property categoryType:      CATEGORY_TYPES  read FcategoryType write FcategoryType;
  end;



  // ************************************************************************ //
  // XML       : SurveysQuestions, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  SurveysQuestions = class(TRemotable)
  private
    FidSurveyQuestion: string;
    FidSurveyQuestion_Specified: boolean;
    FidSurvey: string;
    FidSurvey_Specified: boolean;
    Fquestion: string;
    Fquestion_Specified: boolean;
    Fanswer1: string;
    Fanswer1_Specified: boolean;
    Fanswer2: string;
    Fanswer2_Specified: boolean;
    Fanswer3: string;
    Fanswer3_Specified: boolean;
    Fcorrect: Integer;
    FisEnabled: Boolean;
    procedure SetidSurveyQuestion(Index: Integer; const Astring: string);
    function  idSurveyQuestion_Specified(Index: Integer): boolean;
    procedure SetidSurvey(Index: Integer; const Astring: string);
    function  idSurvey_Specified(Index: Integer): boolean;
    procedure Setquestion(Index: Integer; const Astring: string);
    function  question_Specified(Index: Integer): boolean;
    procedure Setanswer1(Index: Integer; const Astring: string);
    function  answer1_Specified(Index: Integer): boolean;
    procedure Setanswer2(Index: Integer; const Astring: string);
    function  answer2_Specified(Index: Integer): boolean;
    procedure Setanswer3(Index: Integer; const Astring: string);
    function  answer3_Specified(Index: Integer): boolean;
  published
    property idSurveyQuestion: string   Index (IS_OPTN) read FidSurveyQuestion write SetidSurveyQuestion stored idSurveyQuestion_Specified;
    property idSurvey:         string   Index (IS_OPTN) read FidSurvey write SetidSurvey stored idSurvey_Specified;
    property question:         string   Index (IS_OPTN) read Fquestion write Setquestion stored question_Specified;
    property answer1:          string   Index (IS_OPTN) read Fanswer1 write Setanswer1 stored answer1_Specified;
    property answer2:          string   Index (IS_OPTN) read Fanswer2 write Setanswer2 stored answer2_Specified;
    property answer3:          string   Index (IS_OPTN) read Fanswer3 write Setanswer3 stored answer3_Specified;
    property correct:          Integer  read Fcorrect write Fcorrect;
    property isEnabled:        Boolean  read FisEnabled write FisEnabled;
  end;



  // ************************************************************************ //
  // XML       : LanguagesResources, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  LanguagesResources = class(TRemotable)
  private
    FidLanguage: string;
    FidLanguage_Specified: boolean;
    FidResource: string;
    FidResource_Specified: boolean;
    Flabel_: string;
    Flabel__Specified: boolean;
    FlabelExtra: string;
    FlabelExtra_Specified: boolean;
    Fhelp: string;
    Fhelp_Specified: boolean;
    FhelpExtra: string;
    FhelpExtra_Specified: boolean;
    procedure SetidLanguage(Index: Integer; const Astring: string);
    function  idLanguage_Specified(Index: Integer): boolean;
    procedure SetidResource(Index: Integer; const Astring: string);
    function  idResource_Specified(Index: Integer): boolean;
    procedure Setlabel_(Index: Integer; const Astring: string);
    function  label__Specified(Index: Integer): boolean;
    procedure SetlabelExtra(Index: Integer; const Astring: string);
    function  labelExtra_Specified(Index: Integer): boolean;
    procedure Sethelp(Index: Integer; const Astring: string);
    function  help_Specified(Index: Integer): boolean;
    procedure SethelpExtra(Index: Integer; const Astring: string);
    function  helpExtra_Specified(Index: Integer): boolean;
  published
    property idLanguage: string  Index (IS_OPTN) read FidLanguage write SetidLanguage stored idLanguage_Specified;
    property idResource: string  Index (IS_OPTN) read FidResource write SetidResource stored idResource_Specified;
    property label_:     string  Index (IS_OPTN) read Flabel_ write Setlabel_ stored label__Specified;
    property labelExtra: string  Index (IS_OPTN) read FlabelExtra write SetlabelExtra stored labelExtra_Specified;
    property help:       string  Index (IS_OPTN) read Fhelp write Sethelp stored help_Specified;
    property helpExtra:  string  Index (IS_OPTN) read FhelpExtra write SethelpExtra stored helpExtra_Specified;
  end;



  // ************************************************************************ //
  // XML       : ProductsPositionsRelations, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsPositionsRelations = class(TRemotable)
  private
    FidProductPositionRelations: string;
    FidProductPositionRelations_Specified: boolean;
    FidProductPosition: string;
    FidProductPosition_Specified: boolean;
    FidProduct: string;
    FidProduct_Specified: boolean;
    Fcounter: Integer;
    Fposition: Integer;
    procedure SetidProductPositionRelations(Index: Integer; const Astring: string);
    function  idProductPositionRelations_Specified(Index: Integer): boolean;
    procedure SetidProductPosition(Index: Integer; const Astring: string);
    function  idProductPosition_Specified(Index: Integer): boolean;
    procedure SetidProduct(Index: Integer; const Astring: string);
    function  idProduct_Specified(Index: Integer): boolean;
  published
    property idProductPositionRelations: string   Index (IS_OPTN) read FidProductPositionRelations write SetidProductPositionRelations stored idProductPositionRelations_Specified;
    property idProductPosition:          string   Index (IS_OPTN) read FidProductPosition write SetidProductPosition stored idProductPosition_Specified;
    property idProduct:                  string   Index (IS_OPTN) read FidProduct write SetidProduct stored idProduct_Specified;
    property counter:                    Integer  read Fcounter write Fcounter;
    property position:                   Integer  read Fposition write Fposition;
  end;



  // ************************************************************************ //
  // XML       : Queues, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Queues = class(TRemotable)
  private
    FidQueue: string;
    FidQueue_Specified: boolean;
    FidQueueGroup: string;
    FidQueueGroup_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    Fplace: string;
    Fplace_Specified: boolean;
    Fcolor: string;
    Fcolor_Specified: boolean;
    Fletter: string;
    Fletter_Specified: boolean;
    Fpriority: QUEUE_PRIORITY;
    FmaxPlaces: Integer;
    FsendMail: Boolean;
    FonlyValidatedUsers: Boolean;
    procedure SetidQueue(Index: Integer; const Astring: string);
    function  idQueue_Specified(Index: Integer): boolean;
    procedure SetidQueueGroup(Index: Integer; const Astring: string);
    function  idQueueGroup_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setplace(Index: Integer; const Astring: string);
    function  place_Specified(Index: Integer): boolean;
    procedure Setcolor(Index: Integer; const Astring: string);
    function  color_Specified(Index: Integer): boolean;
    procedure Setletter(Index: Integer; const Astring: string);
    function  letter_Specified(Index: Integer): boolean;
  published
    property idQueue:            string          Index (IS_OPTN) read FidQueue write SetidQueue stored idQueue_Specified;
    property idQueueGroup:       string          Index (IS_OPTN) read FidQueueGroup write SetidQueueGroup stored idQueueGroup_Specified;
    property name_:              string          Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property place:              string          Index (IS_OPTN) read Fplace write Setplace stored place_Specified;
    property color:              string          Index (IS_OPTN) read Fcolor write Setcolor stored color_Specified;
    property letter:             string          Index (IS_OPTN) read Fletter write Setletter stored letter_Specified;
    property priority:           QUEUE_PRIORITY  read Fpriority write Fpriority;
    property maxPlaces:          Integer         read FmaxPlaces write FmaxPlaces;
    property sendMail:           Boolean         read FsendMail write FsendMail;
    property onlyValidatedUsers: Boolean         read FonlyValidatedUsers write FonlyValidatedUsers;
  end;



  // ************************************************************************ //
  // XML       : ProductsPositions, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsPositions = class(TRemotable)
  private
    FidProductPosition: string;
    FidProductPosition_Specified: boolean;
    Ftitle: string;
    Ftitle_Specified: boolean;
    procedure SetidProductPosition(Index: Integer; const Astring: string);
    function  idProductPosition_Specified(Index: Integer): boolean;
    procedure Settitle(Index: Integer; const Astring: string);
    function  title_Specified(Index: Integer): boolean;
  published
    property idProductPosition: string  Index (IS_OPTN) read FidProductPosition write SetidProductPosition stored idProductPosition_Specified;
    property title:             string  Index (IS_OPTN) read Ftitle write Settitle stored title_Specified;
  end;

  ArrayOfAnyType = array of string;             { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Channels, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Channels = class(TRemotable)
  private
    FidChannel: string;
    FidChannel_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    FchannelType: CHANNEL_TYPE;
    Furl: string;
    Furl_Specified: boolean;
    procedure SetidChannel(Index: Integer; const Astring: string);
    function  idChannel_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Seturl(Index: Integer; const Astring: string);
    function  url_Specified(Index: Integer): boolean;
  published
    property idChannel:   string        Index (IS_OPTN) read FidChannel write SetidChannel stored idChannel_Specified;
    property name_:       string        Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property channelType: CHANNEL_TYPE  read FchannelType write FchannelType;
    property url:         string        Index (IS_OPTN) read Furl write Seturl stored url_Specified;
  end;



  // ************************************************************************ //
  // XML       : ChannelsCameras, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ChannelsCameras = class(TRemotable)
  private
    FidChannel: string;
    FidChannel_Specified: boolean;
    FcameraType: CHANNEL_CAMERA_TYPE;
    Fconfiguration: string;
    Fconfiguration_Specified: boolean;
    procedure SetidChannel(Index: Integer; const Astring: string);
    function  idChannel_Specified(Index: Integer): boolean;
    procedure Setconfiguration(Index: Integer; const Astring: string);
    function  configuration_Specified(Index: Integer): boolean;
  published
    property idChannel:     string               Index (IS_OPTN) read FidChannel write SetidChannel stored idChannel_Specified;
    property cameraType:    CHANNEL_CAMERA_TYPE  read FcameraType write FcameraType;
    property configuration: string               Index (IS_OPTN) read Fconfiguration write Setconfiguration stored configuration_Specified;
  end;



  // ************************************************************************ //
  // XML       : SurveysAnswers, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  SurveysAnswers = class(TRemotable)
  private
    FidSurverAnswer: string;
    FidSurverAnswer_Specified: boolean;
    FidSurveyQuestion: string;
    FidSurveyQuestion_Specified: boolean;
    FidPlayer: string;
    FidPlayer_Specified: boolean;
    FansweredDate: TXSDateTime;
    FansweredTime: TXSDateTime;
    Fanswered: Integer;
    FansweredCorrect: Boolean;
    FuserName: string;
    FuserName_Specified: boolean;
    FidUser: string;
    FidUser_Specified: boolean;
    procedure SetidSurverAnswer(Index: Integer; const Astring: string);
    function  idSurverAnswer_Specified(Index: Integer): boolean;
    procedure SetidSurveyQuestion(Index: Integer; const Astring: string);
    function  idSurveyQuestion_Specified(Index: Integer): boolean;
    procedure SetidPlayer(Index: Integer; const Astring: string);
    function  idPlayer_Specified(Index: Integer): boolean;
    procedure SetuserName(Index: Integer; const Astring: string);
    function  userName_Specified(Index: Integer): boolean;
    procedure SetidUser(Index: Integer; const Astring: string);
    function  idUser_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idSurverAnswer:   string       Index (IS_OPTN) read FidSurverAnswer write SetidSurverAnswer stored idSurverAnswer_Specified;
    property idSurveyQuestion: string       Index (IS_OPTN) read FidSurveyQuestion write SetidSurveyQuestion stored idSurveyQuestion_Specified;
    property idPlayer:         string       Index (IS_OPTN) read FidPlayer write SetidPlayer stored idPlayer_Specified;
    property answeredDate:     TXSDateTime  read FansweredDate write FansweredDate;
    property answeredTime:     TXSDateTime  read FansweredTime write FansweredTime;
    property answered:         Integer      read Fanswered write Fanswered;
    property answeredCorrect:  Boolean      read FansweredCorrect write FansweredCorrect;
    property userName:         string       Index (IS_OPTN) read FuserName write SetuserName stored userName_Specified;
    property idUser:           string       Index (IS_OPTN) read FidUser write SetidUser stored idUser_Specified;
  end;



  // ************************************************************************ //
  // XML       : Users, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Users = class(TRemotable)
  private
    FidUser: string;
    FidUser_Specified: boolean;
    FidCompany: string;
    FidCompany_Specified: boolean;
    FfirstName: string;
    FfirstName_Specified: boolean;
    FlastName: string;
    FlastName_Specified: boolean;
    Femail: string;
    Femail_Specified: boolean;
    Fbirthday: string;
    Fbirthday_Specified: boolean;
    FregistrationDate: string;
    FregistrationDate_Specified: boolean;
    Fphone: string;
    Fphone_Specified: boolean;
    Fmobile: string;
    Fmobile_Specified: boolean;
    Fpassword: string;
    Fpassword_Specified: boolean;
    FpinCode: string;
    FpinCode_Specified: boolean;
    Fdni: string;
    Fdni_Specified: boolean;
    FtotalLogin: Integer;
    FaccessLevel: ACCESS_LEVEL;
    FpinCodeExpirationDate: TXSDateTime;
    FlastBadLogin: TXSDateTime;
    FidProfessional: string;
    FidProfessional_Specified: boolean;
    FidSocial: string;
    FidSocial_Specified: boolean;
    FsocialNumber: string;
    FsocialNumber_Specified: boolean;
    FsocialPlan: string;
    FsocialPlan_Specified: boolean;
    FsocialDate: TXSDateTime;
    Fcity: string;
    Fcity_Specified: boolean;
    Faddress: string;
    Faddress_Specified: boolean;
    FgeoLat: Double;
    FgeoLon: Double;
    procedure SetidUser(Index: Integer; const Astring: string);
    function  idUser_Specified(Index: Integer): boolean;
    procedure SetidCompany(Index: Integer; const Astring: string);
    function  idCompany_Specified(Index: Integer): boolean;
    procedure SetfirstName(Index: Integer; const Astring: string);
    function  firstName_Specified(Index: Integer): boolean;
    procedure SetlastName(Index: Integer; const Astring: string);
    function  lastName_Specified(Index: Integer): boolean;
    procedure Setemail(Index: Integer; const Astring: string);
    function  email_Specified(Index: Integer): boolean;
    procedure Setbirthday(Index: Integer; const Astring: string);
    function  birthday_Specified(Index: Integer): boolean;
    procedure SetregistrationDate(Index: Integer; const Astring: string);
    function  registrationDate_Specified(Index: Integer): boolean;
    procedure Setphone(Index: Integer; const Astring: string);
    function  phone_Specified(Index: Integer): boolean;
    procedure Setmobile(Index: Integer; const Astring: string);
    function  mobile_Specified(Index: Integer): boolean;
    procedure Setpassword(Index: Integer; const Astring: string);
    function  password_Specified(Index: Integer): boolean;
    procedure SetpinCode(Index: Integer; const Astring: string);
    function  pinCode_Specified(Index: Integer): boolean;
    procedure Setdni(Index: Integer; const Astring: string);
    function  dni_Specified(Index: Integer): boolean;
    procedure SetidProfessional(Index: Integer; const Astring: string);
    function  idProfessional_Specified(Index: Integer): boolean;
    procedure SetidSocial(Index: Integer; const Astring: string);
    function  idSocial_Specified(Index: Integer): boolean;
    procedure SetsocialNumber(Index: Integer; const Astring: string);
    function  socialNumber_Specified(Index: Integer): boolean;
    procedure SetsocialPlan(Index: Integer; const Astring: string);
    function  socialPlan_Specified(Index: Integer): boolean;
    procedure Setcity(Index: Integer; const Astring: string);
    function  city_Specified(Index: Integer): boolean;
    procedure Setaddress(Index: Integer; const Astring: string);
    function  address_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idUser:                string        Index (IS_OPTN) read FidUser write SetidUser stored idUser_Specified;
    property idCompany:             string        Index (IS_OPTN) read FidCompany write SetidCompany stored idCompany_Specified;
    property firstName:             string        Index (IS_OPTN) read FfirstName write SetfirstName stored firstName_Specified;
    property lastName:              string        Index (IS_OPTN) read FlastName write SetlastName stored lastName_Specified;
    property email:                 string        Index (IS_OPTN) read Femail write Setemail stored email_Specified;
    property birthday:              string        Index (IS_OPTN) read Fbirthday write Setbirthday stored birthday_Specified;
    property registrationDate:      string        Index (IS_OPTN) read FregistrationDate write SetregistrationDate stored registrationDate_Specified;
    property phone:                 string        Index (IS_OPTN) read Fphone write Setphone stored phone_Specified;
    property mobile:                string        Index (IS_OPTN) read Fmobile write Setmobile stored mobile_Specified;
    property password:              string        Index (IS_OPTN) read Fpassword write Setpassword stored password_Specified;
    property pinCode:               string        Index (IS_OPTN) read FpinCode write SetpinCode stored pinCode_Specified;
    property dni:                   string        Index (IS_OPTN) read Fdni write Setdni stored dni_Specified;
    property totalLogin:            Integer       read FtotalLogin write FtotalLogin;
    property accessLevel:           ACCESS_LEVEL  read FaccessLevel write FaccessLevel;
    property pinCodeExpirationDate: TXSDateTime   read FpinCodeExpirationDate write FpinCodeExpirationDate;
    property lastBadLogin:          TXSDateTime   read FlastBadLogin write FlastBadLogin;
    property idProfessional:        string        Index (IS_OPTN) read FidProfessional write SetidProfessional stored idProfessional_Specified;
    property idSocial:              string        Index (IS_OPTN) read FidSocial write SetidSocial stored idSocial_Specified;
    property socialNumber:          string        Index (IS_OPTN) read FsocialNumber write SetsocialNumber stored socialNumber_Specified;
    property socialPlan:            string        Index (IS_OPTN) read FsocialPlan write SetsocialPlan stored socialPlan_Specified;
    property socialDate:            TXSDateTime   read FsocialDate write FsocialDate;
    property city:                  string        Index (IS_OPTN) read Fcity write Setcity stored city_Specified;
    property address:               string        Index (IS_OPTN) read Faddress write Setaddress stored address_Specified;
    property geoLat:                Double        read FgeoLat write FgeoLat;
    property geoLon:                Double        read FgeoLon write FgeoLon;
  end;



  // ************************************************************************ //
  // XML       : Products, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Products = class(TRemotable)
  private
    FidProduct: string;
    FidProduct_Specified: boolean;
    FidProductCategory: string;
    FidProductCategory_Specified: boolean;
    FidProductBrand: string;
    FidProductBrand_Specified: boolean;
    Fbrand: string;
    Fbrand_Specified: boolean;
    FbrandType: string;
    FbrandType_Specified: boolean;
    FbrandStyle: string;
    FbrandStyle_Specified: boolean;
    FbrandStyleExtra: string;
    FbrandStyleExtra_Specified: boolean;
    Frelated01: string;
    Frelated01_Specified: boolean;
    Frelated02: string;
    Frelated02_Specified: boolean;
    Frelated03: string;
    Frelated03_Specified: boolean;
    FbarCode01: string;
    FbarCode01_Specified: boolean;
    FbarCode02: string;
    FbarCode02_Specified: boolean;
    FbarCode03: string;
    FbarCode03_Specified: boolean;
    Ftitle: string;
    Ftitle_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    Fprice: Double;
    Fwidth: Integer;
    Fheight: Integer;
    Fpoints: Integer;
    Fitems: Integer;
    Fstock: Integer;
    FidProductGroup: string;
    FidProductGroup_Specified: boolean;
    FdisplayOrder: Integer;
    FisActive: Boolean;
    Fcategory: ProductsCategories;
    Fcategory_Specified: boolean;
    FdisplayOrderCounter: Integer;
    FidProductPositionRelations: string;
    FidProductPositionRelations_Specified: boolean;
    FlanguagesResources: ArrayOfLanguagesResources;
    FlanguagesResources_Specified: boolean;
    procedure SetidProduct(Index: Integer; const Astring: string);
    function  idProduct_Specified(Index: Integer): boolean;
    procedure SetidProductCategory(Index: Integer; const Astring: string);
    function  idProductCategory_Specified(Index: Integer): boolean;
    procedure SetidProductBrand(Index: Integer; const Astring: string);
    function  idProductBrand_Specified(Index: Integer): boolean;
    procedure Setbrand(Index: Integer; const Astring: string);
    function  brand_Specified(Index: Integer): boolean;
    procedure SetbrandType(Index: Integer; const Astring: string);
    function  brandType_Specified(Index: Integer): boolean;
    procedure SetbrandStyle(Index: Integer; const Astring: string);
    function  brandStyle_Specified(Index: Integer): boolean;
    procedure SetbrandStyleExtra(Index: Integer; const Astring: string);
    function  brandStyleExtra_Specified(Index: Integer): boolean;
    procedure Setrelated01(Index: Integer; const Astring: string);
    function  related01_Specified(Index: Integer): boolean;
    procedure Setrelated02(Index: Integer; const Astring: string);
    function  related02_Specified(Index: Integer): boolean;
    procedure Setrelated03(Index: Integer; const Astring: string);
    function  related03_Specified(Index: Integer): boolean;
    procedure SetbarCode01(Index: Integer; const Astring: string);
    function  barCode01_Specified(Index: Integer): boolean;
    procedure SetbarCode02(Index: Integer; const Astring: string);
    function  barCode02_Specified(Index: Integer): boolean;
    procedure SetbarCode03(Index: Integer; const Astring: string);
    function  barCode03_Specified(Index: Integer): boolean;
    procedure Settitle(Index: Integer; const Astring: string);
    function  title_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
    procedure SetidProductGroup(Index: Integer; const Astring: string);
    function  idProductGroup_Specified(Index: Integer): boolean;
    procedure Setcategory(Index: Integer; const AProductsCategories: ProductsCategories);
    function  category_Specified(Index: Integer): boolean;
    procedure SetidProductPositionRelations(Index: Integer; const Astring: string);
    function  idProductPositionRelations_Specified(Index: Integer): boolean;
    procedure SetlanguagesResources(Index: Integer; const AArrayOfLanguagesResources: ArrayOfLanguagesResources);
    function  languagesResources_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idProduct:                  string                     Index (IS_OPTN) read FidProduct write SetidProduct stored idProduct_Specified;
    property idProductCategory:          string                     Index (IS_OPTN) read FidProductCategory write SetidProductCategory stored idProductCategory_Specified;
    property idProductBrand:             string                     Index (IS_OPTN) read FidProductBrand write SetidProductBrand stored idProductBrand_Specified;
    property brand:                      string                     Index (IS_OPTN) read Fbrand write Setbrand stored brand_Specified;
    property brandType:                  string                     Index (IS_OPTN) read FbrandType write SetbrandType stored brandType_Specified;
    property brandStyle:                 string                     Index (IS_OPTN) read FbrandStyle write SetbrandStyle stored brandStyle_Specified;
    property brandStyleExtra:            string                     Index (IS_OPTN) read FbrandStyleExtra write SetbrandStyleExtra stored brandStyleExtra_Specified;
    property related01:                  string                     Index (IS_OPTN) read Frelated01 write Setrelated01 stored related01_Specified;
    property related02:                  string                     Index (IS_OPTN) read Frelated02 write Setrelated02 stored related02_Specified;
    property related03:                  string                     Index (IS_OPTN) read Frelated03 write Setrelated03 stored related03_Specified;
    property barCode01:                  string                     Index (IS_OPTN) read FbarCode01 write SetbarCode01 stored barCode01_Specified;
    property barCode02:                  string                     Index (IS_OPTN) read FbarCode02 write SetbarCode02 stored barCode02_Specified;
    property barCode03:                  string                     Index (IS_OPTN) read FbarCode03 write SetbarCode03 stored barCode03_Specified;
    property title:                      string                     Index (IS_OPTN) read Ftitle write Settitle stored title_Specified;
    property description:                string                     Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property price:                      Double                     read Fprice write Fprice;
    property width:                      Integer                    read Fwidth write Fwidth;
    property height:                     Integer                    read Fheight write Fheight;
    property points:                     Integer                    read Fpoints write Fpoints;
    property items:                      Integer                    read Fitems write Fitems;
    property stock:                      Integer                    read Fstock write Fstock;
    property idProductGroup:             string                     Index (IS_OPTN) read FidProductGroup write SetidProductGroup stored idProductGroup_Specified;
    property displayOrder:               Integer                    read FdisplayOrder write FdisplayOrder;
    property isActive:                   Boolean                    read FisActive write FisActive;
    property category:                   ProductsCategories         Index (IS_OPTN) read Fcategory write Setcategory stored category_Specified;
    property displayOrderCounter:        Integer                    read FdisplayOrderCounter write FdisplayOrderCounter;
    property idProductPositionRelations: string                     Index (IS_OPTN) read FidProductPositionRelations write SetidProductPositionRelations stored idProductPositionRelations_Specified;
    property languagesResources:         ArrayOfLanguagesResources  Index (IS_OPTN) read FlanguagesResources write SetlanguagesResources stored languagesResources_Specified;
  end;



  // ************************************************************************ //
  // XML       : QueuesShifts, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  QueuesShifts = class(TRemotable)
  private
    FidQueueShift: string;
    FidQueueShift_Specified: boolean;
    FidQueue: string;
    FidQueue_Specified: boolean;
    FidParentQueue: string;
    FidParentQueue_Specified: boolean;
    Fletter: string;
    Fletter_Specified: boolean;
    FidQueueCustomer: string;
    FidQueueCustomer_Specified: boolean;
    FidNumber: Integer;
    FidUser: string;
    FidUser_Specified: boolean;
    FidPlayer: string;
    FidPlayer_Specified: boolean;
    Freason: string;
    Freason_Specified: boolean;
    FqueueDate: TXSDateTime;
    FqueueTime: Double;
    FqueueStartTime: Double;
    FqueueEndTime: Double;
    FqueueCalls: Integer;
    FsentMail: Boolean;
    procedure SetidQueueShift(Index: Integer; const Astring: string);
    function  idQueueShift_Specified(Index: Integer): boolean;
    procedure SetidQueue(Index: Integer; const Astring: string);
    function  idQueue_Specified(Index: Integer): boolean;
    procedure SetidParentQueue(Index: Integer; const Astring: string);
    function  idParentQueue_Specified(Index: Integer): boolean;
    procedure Setletter(Index: Integer; const Astring: string);
    function  letter_Specified(Index: Integer): boolean;
    procedure SetidQueueCustomer(Index: Integer; const Astring: string);
    function  idQueueCustomer_Specified(Index: Integer): boolean;
    procedure SetidUser(Index: Integer; const Astring: string);
    function  idUser_Specified(Index: Integer): boolean;
    procedure SetidPlayer(Index: Integer; const Astring: string);
    function  idPlayer_Specified(Index: Integer): boolean;
    procedure Setreason(Index: Integer; const Astring: string);
    function  reason_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idQueueShift:    string       Index (IS_OPTN) read FidQueueShift write SetidQueueShift stored idQueueShift_Specified;
    property idQueue:         string       Index (IS_OPTN) read FidQueue write SetidQueue stored idQueue_Specified;
    property idParentQueue:   string       Index (IS_OPTN) read FidParentQueue write SetidParentQueue stored idParentQueue_Specified;
    property letter:          string       Index (IS_OPTN) read Fletter write Setletter stored letter_Specified;
    property idQueueCustomer: string       Index (IS_OPTN) read FidQueueCustomer write SetidQueueCustomer stored idQueueCustomer_Specified;
    property idNumber:        Integer      read FidNumber write FidNumber;
    property idUser:          string       Index (IS_OPTN) read FidUser write SetidUser stored idUser_Specified;
    property idPlayer:        string       Index (IS_OPTN) read FidPlayer write SetidPlayer stored idPlayer_Specified;
    property reason:          string       Index (IS_OPTN) read Freason write Setreason stored reason_Specified;
    property queueDate:       TXSDateTime  read FqueueDate write FqueueDate;
    property queueTime:       Double       read FqueueTime write FqueueTime;
    property queueStartTime:  Double       read FqueueStartTime write FqueueStartTime;
    property queueEndTime:    Double       read FqueueEndTime write FqueueEndTime;
    property queueCalls:      Integer      read FqueueCalls write FqueueCalls;
    property sentMail:        Boolean      read FsentMail write FsentMail;
  end;



  // ************************************************************************ //
  // XML       : PlayersGroups, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersGroups = class(TRemotable)
  private
    FidPlayerGroup: string;
    FidPlayerGroup_Specified: boolean;
    FidParent: string;
    FidParent_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    procedure SetidPlayerGroup(Index: Integer; const Astring: string);
    function  idPlayerGroup_Specified(Index: Integer): boolean;
    procedure SetidParent(Index: Integer; const Astring: string);
    function  idParent_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
  published
    property idPlayerGroup: string  Index (IS_OPTN) read FidPlayerGroup write SetidPlayerGroup stored idPlayerGroup_Specified;
    property idParent:      string  Index (IS_OPTN) read FidParent write SetidParent stored idParent_Specified;
    property name_:         string  Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
  end;

  ArrayOfQueues = array of Queues;              { "http://tempuri.org/"[GblCplx] }
  ArrayOfChannels = array of Channels;          { "http://tempuri.org/"[GblCplx] }
  ArrayOfChannelsCameras = array of ChannelsCameras;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfQueuesShifts = array of QueuesShifts;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfProducts = array of Products;          { "http://tempuri.org/"[GblCplx] }
  ArrayOfProductsPositionsRelations = array of ProductsPositionsRelations;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfProductsPositions = array of ProductsPositions;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfFileNode = array of FileNode;          { "http://tempuri.org/"[GblCplx] }
  ArrayOfPlayersGroups = array of PlayersGroups;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfUsers = array of Users;                { "http://tempuri.org/"[GblCplx] }
  ArrayOfQueuesGroups = array of QueuesGroups;   { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : PlayersDesigns, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersDesigns = class(TRemotable)
  private
    FidPlayerDesign: string;
    FidPlayerDesign_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    FisEnabled: Boolean;
    FimageBase64: string;
    FimageBase64_Specified: boolean;
    procedure SetidPlayerDesign(Index: Integer; const Astring: string);
    function  idPlayerDesign_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
    procedure SetimageBase64(Index: Integer; const Astring: string);
    function  imageBase64_Specified(Index: Integer): boolean;
  published
    property idPlayerDesign: string   Index (IS_OPTN) read FidPlayerDesign write SetidPlayerDesign stored idPlayerDesign_Specified;
    property description:    string   Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property isEnabled:      Boolean  read FisEnabled write FisEnabled;
    property imageBase64:    string   Index (IS_OPTN) read FimageBase64 write SetimageBase64 stored imageBase64_Specified;
  end;



  // ************************************************************************ //
  // XML       : LicenseEntity, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  LicenseEntity = class(TRemotable)
  private
    FAppName: string;
    FAppName_Specified: boolean;
    FUID: string;
    FUID_Specified: boolean;
    FType_: LicenseTypes;
    FCreateDateTime: TXSDateTime;
    procedure SetAppName(Index: Integer; const Astring: string);
    function  AppName_Specified(Index: Integer): boolean;
    procedure SetUID(Index: Integer; const Astring: string);
    function  UID_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property AppName:        string        Index (IS_OPTN) read FAppName write SetAppName stored AppName_Specified;
    property UID:            string        Index (IS_OPTN) read FUID write SetUID stored UID_Specified;
    property Type_:          LicenseTypes  read FType_ write FType_;
    property CreateDateTime: TXSDateTime   read FCreateDateTime write FCreateDateTime;
  end;



  // ************************************************************************ //
  // XML       : Surveys, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Surveys = class(TRemotable)
  private
    FidSurvey: string;
    FidSurvey_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    FstartDate: TXSDateTime;
    FendDate: TXSDateTime;
    FquestionsToAsk: Integer;
    FquestionsToWin: Integer;
    FquestionsTime: Integer;
    FisEnabled: Boolean;
    FisAnonymous: Boolean;
    procedure SetidSurvey(Index: Integer; const Astring: string);
    function  idSurvey_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idSurvey:       string       Index (IS_OPTN) read FidSurvey write SetidSurvey stored idSurvey_Specified;
    property name_:          string       Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property startDate:      TXSDateTime  read FstartDate write FstartDate;
    property endDate:        TXSDateTime  read FendDate write FendDate;
    property questionsToAsk: Integer      read FquestionsToAsk write FquestionsToAsk;
    property questionsToWin: Integer      read FquestionsToWin write FquestionsToWin;
    property questionsTime:  Integer      read FquestionsTime write FquestionsTime;
    property isEnabled:      Boolean      read FisEnabled write FisEnabled;
    property isAnonymous:    Boolean      read FisAnonymous write FisAnonymous;
  end;



  // ************************************************************************ //
  // XML       : Players, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Players = class(TRemotable)
  private
    FidPlayer: string;
    FidPlayer_Specified: boolean;
    FidPlayerGroup: string;
    FidPlayerGroup_Specified: boolean;
    Fip: string;
    Fip_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    Fplace: string;
    Fplace_Specified: boolean;
    Fmodel: string;
    Fmodel_Specified: boolean;
    FequipmentType: EQUIPMENT_TYPE;
    FdiskSpace: Integer;
    FtotalScreens: Integer;
    FlastReport: TXSDateTime;
    FlastUpdate: string;
    FlastUpdate_Specified: boolean;
    FscreenSaverTime: Integer;
    FscreenSaverScreens: SCREEN_SAVER_TYPE;
    FscreenSaverIdPlayerDesign: string;
    FscreenSaverIdPlayerDesign_Specified: boolean;
    procedure SetidPlayer(Index: Integer; const Astring: string);
    function  idPlayer_Specified(Index: Integer): boolean;
    procedure SetidPlayerGroup(Index: Integer; const Astring: string);
    function  idPlayerGroup_Specified(Index: Integer): boolean;
    procedure Setip(Index: Integer; const Astring: string);
    function  ip_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setplace(Index: Integer; const Astring: string);
    function  place_Specified(Index: Integer): boolean;
    procedure Setmodel(Index: Integer; const Astring: string);
    function  model_Specified(Index: Integer): boolean;
    procedure SetlastUpdate(Index: Integer; const Astring: string);
    function  lastUpdate_Specified(Index: Integer): boolean;
    procedure SetscreenSaverIdPlayerDesign(Index: Integer; const Astring: string);
    function  screenSaverIdPlayerDesign_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idPlayer:                  string             Index (IS_OPTN) read FidPlayer write SetidPlayer stored idPlayer_Specified;
    property idPlayerGroup:             string             Index (IS_OPTN) read FidPlayerGroup write SetidPlayerGroup stored idPlayerGroup_Specified;
    property ip:                        string             Index (IS_OPTN) read Fip write Setip stored ip_Specified;
    property name_:                     string             Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property place:                     string             Index (IS_OPTN) read Fplace write Setplace stored place_Specified;
    property model:                     string             Index (IS_OPTN) read Fmodel write Setmodel stored model_Specified;
    property equipmentType:             EQUIPMENT_TYPE     read FequipmentType write FequipmentType;
    property diskSpace:                 Integer            read FdiskSpace write FdiskSpace;
    property totalScreens:              Integer            read FtotalScreens write FtotalScreens;
    property lastReport:                TXSDateTime        read FlastReport write FlastReport;
    property lastUpdate:                string             Index (IS_OPTN) read FlastUpdate write SetlastUpdate stored lastUpdate_Specified;
    property screenSaverTime:           Integer            read FscreenSaverTime write FscreenSaverTime;
    property screenSaverScreens:        SCREEN_SAVER_TYPE  read FscreenSaverScreens write FscreenSaverScreens;
    property screenSaverIdPlayerDesign: string             Index (IS_OPTN) read FscreenSaverIdPlayerDesign write SetscreenSaverIdPlayerDesign stored screenSaverIdPlayerDesign_Specified;
  end;

  ArrayOfPlayersDesigns = array of PlayersDesigns;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfPlayers = array of Players;            { "http://tempuri.org/"[GblCplx] }
  ArrayOfSurveysQuestions = array of SurveysQuestions;   { "http://tempuri.org/"[GblCplx] }
  ArrayOfPlayersTimeLine = array of PlayersTimeLine;   { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : TecnoSignageLicense, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  TecnoSignageLicense = class(LicenseEntity)
  private
    FLicenseType: LicenseTypesTecnoSignage;
    FEnableQueue: Boolean;
    FEnableGames: Boolean;
    FEnableAppointment: Boolean;
    FEnableProducts: Boolean;
  published
    property LicenseType:       LicenseTypesTecnoSignage  read FLicenseType write FLicenseType;
    property EnableQueue:       Boolean                   read FEnableQueue write FEnableQueue;
    property EnableGames:       Boolean                   read FEnableGames write FEnableGames;
    property EnableAppointment: Boolean                   read FEnableAppointment write FEnableAppointment;
    property EnableProducts:    Boolean                   read FEnableProducts write FEnableProducts;
  end;



  // ************************************************************************ //
  // XML       : PlayersTimeLine, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersTimeLine = class(TRemotable)
  private
    FidPlayerTimeLine: string;
    FidPlayerTimeLine_Specified: boolean;
    FidPlayerDesign: string;
    FidPlayerDesign_Specified: boolean;
    FidPlayerGroup: string;
    FidPlayerGroup_Specified: boolean;
    FdateReleased: TXSDateTime;
    Fdescription: string;
    Fdescription_Specified: boolean;
    FisActive: Boolean;
    Fdestination: Integer;
    FscheduleStartDate: TXSDateTime;
    FscheduleStartTime: Double;
    FscheduleEndDate: TXSDateTime;
    FscheduleEndTime: Double;
    FscheduleRepeat: Integer;
    Fday: Integer;
    procedure SetidPlayerTimeLine(Index: Integer; const Astring: string);
    function  idPlayerTimeLine_Specified(Index: Integer): boolean;
    procedure SetidPlayerDesign(Index: Integer; const Astring: string);
    function  idPlayerDesign_Specified(Index: Integer): boolean;
    procedure SetidPlayerGroup(Index: Integer; const Astring: string);
    function  idPlayerGroup_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property idPlayerTimeLine:  string       Index (IS_OPTN) read FidPlayerTimeLine write SetidPlayerTimeLine stored idPlayerTimeLine_Specified;
    property idPlayerDesign:    string       Index (IS_OPTN) read FidPlayerDesign write SetidPlayerDesign stored idPlayerDesign_Specified;
    property idPlayerGroup:     string       Index (IS_OPTN) read FidPlayerGroup write SetidPlayerGroup stored idPlayerGroup_Specified;
    property dateReleased:      TXSDateTime  read FdateReleased write FdateReleased;
    property description:       string       Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property isActive:          Boolean      read FisActive write FisActive;
    property destination:       Integer      read Fdestination write Fdestination;
    property scheduleStartDate: TXSDateTime  read FscheduleStartDate write FscheduleStartDate;
    property scheduleStartTime: Double       read FscheduleStartTime write FscheduleStartTime;
    property scheduleEndDate:   TXSDateTime  read FscheduleEndDate write FscheduleEndDate;
    property scheduleEndTime:   Double       read FscheduleEndTime write FscheduleEndTime;
    property scheduleRepeat:    Integer      read FscheduleRepeat write FscheduleRepeat;
    property day:               Integer      read Fday write Fday;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ManagerSoap
  // service   : Manager
  // port      : ManagerSoap
  // URL       : http://server-llamador/ws/manager.asmx
  // ************************************************************************ //
  ManagerSoap = interface(IInvokable)
  ['{DF6A2955-C36E-9037-F540-3184E3CCE219}']
    function  HelloWorld: string; stdcall;
    function  GetMaxRequestLength: Int64; stdcall;
    procedure AppendChunk(const FileName: string; const buffer: TByteDynArray; const Offset: Int64; const key: string); stdcall;
    function  DownloadChunk(const FileName: string; const Offset: Int64; const BufferSize: Integer; const key: string): TByteDynArray; stdcall;
    function  GetFileSize(const FileName: string): Int64; stdcall;
    function  GetFilesList: ArrayOfString; stdcall;
    function  CheckFileHash(const FileName: string): string; stdcall;
    function  GetUpdates: ArrayOfAnyType; stdcall;
    function  GetPlayersTimeLine: ArrayOfPlayersTimeLine; stdcall;
    function  GetPlayersTimeLineByIdPlayer(const idPlayer: string): ArrayOfPlayersTimeLine; stdcall;
    function  GetLicense: TecnoSignageLicense; stdcall;
    function  GetPlayersDesigns: ArrayOfPlayersDesigns; stdcall;
    function  SaveDesign(const item: PlayersDesigns; const email: string): string; stdcall;
    function  LoginUser(const email: string; const password: string): Boolean; stdcall;
    procedure SetLog(const log: string; const idPlayer: string; const key: string; const type_: PlayersLogType); stdcall;
    function  RegisterPlayer(const player: Players; const key: string): string; stdcall;
    function  PlayerStatus(const idPlayer: string; const diskSpace: Integer; const key: string): Players; stdcall;
    function  GetPlayers(const key: string): ArrayOfPlayers; stdcall;
    function  GetPlayer(const idPlayer: string; const key: string): Players; stdcall;
    function  GetCurrentSurvey: Surveys; stdcall;
    function  GetSurveyQuestions(const idSurvey: string): ArrayOfSurveysQuestions; stdcall;
    procedure UpdateAnswerData(const key: string; const surveyAnswer: SurveysAnswers); stdcall;
    procedure Import(const product: Products; const id: string); stdcall;
    function  GetLanguagesResources: ArrayOfLanguagesResources; stdcall;
    procedure SetProduct(const product: Products; const id: string); stdcall;
    function  GetProducts: ArrayOfProducts; stdcall;
    function  GetProductsPositionsRelations: ArrayOfProductsPositionsRelations; stdcall;
    function  GetProductsPositions: ArrayOfProductsPositions; stdcall;
    function  GetQueuesPending: ArrayOfQueuesShifts; stdcall;
    function  GetQueuesShiftsByIdPlayer(const idPlayer: string): ArrayOfQueuesShifts; stdcall;
    function  GetQueuesByIdPlayer(const idPlayer: string): ArrayOfQueues; stdcall;
    function  GetChannels: ArrayOfChannels; stdcall;
    function  GetChannelsCameras: ArrayOfChannelsCameras; stdcall;
    function  GetQueues: ArrayOfQueues; stdcall;
    function  GetPlayersGroups: ArrayOfPlayersGroups; stdcall;
    function  GetUsers(const key: string): ArrayOfUsers; stdcall;
    function  GetUserByDNI(const key: string; const dni: string): Users; stdcall;
    function  GetUserByFirstName(const key: string; const name_: string): Users; stdcall;
    function  GetUserByLastName(const key: string; const name_: string): Users; stdcall;
    function  GetQueuesGroups: ArrayOfQueuesGroups; stdcall;
    function  IsQueueGroupHidden: Boolean; stdcall;
    function  UpdateQueueShift(const queueShift: QueuesShifts): QueuesShifts; stdcall;
    function  GetAllMedia(const key: string): ArrayOfFileNode; stdcall;
    function  GetAllGames(const key: string): ArrayOfFileNode; stdcall;
    function  GetAllFolderGames(const key: string): ArrayOfFileNode; stdcall;
    function  CheckSyncFileHash(const FileName: string): string; stdcall;
  end;

//function GetManagerSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ManagerSoap;
function GetManagerSoap(UseWSDL: Boolean; Url: string; HTTPRIO: THTTPRIO = nil): ManagerSoap;


implementation
  uses System.SysUtils;

//function GetManagerSoap(UseWSDL: Boolean; Addr: string;  HTTPRIO: THTTPRIO): ManagerSoap;
function GetManagerSoap(UseWSDL: Boolean; Url: string;  HTTPRIO: THTTPRIO): ManagerSoap;
const
  //defWSDL = 'http://server-llamador/ws/manager.asmx?WSDL';
  //defURL  = 'http://server-llamador/ws/manager.asmx';

  defSvc  = 'Manager';
  defPrt  = 'ManagerSoap';

var
  RIO: THTTPRIO;
  Addr : String;
begin
  Result := nil;
  //if (Addr = '') then
  //begin
    if UseWSDL then
      Addr := Format('%s?WSDL', [Url]) //defWSDL
    else
      Addr := Format('%s', [Url]); //defURL;
  //end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ManagerSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure FileNode.Setpath(Index: Integer; const Astring: string);
begin
  Fpath := Astring;
  Fpath_Specified := True;
end;

function FileNode.path_Specified(Index: Integer): boolean;
begin
  Result := Fpath_Specified;
end;

procedure FileNode.SetMD5(Index: Integer; const Astring: string);
begin
  FMD5 := Astring;
  FMD5_Specified := True;
end;

function FileNode.MD5_Specified(Index: Integer): boolean;
begin
  Result := FMD5_Specified;
end;

procedure QueuesGroups.SetidQueueGroup(Index: Integer; const Astring: string);
begin
  FidQueueGroup := Astring;
  FidQueueGroup_Specified := True;
end;

function QueuesGroups.idQueueGroup_Specified(Index: Integer): boolean;
begin
  Result := FidQueueGroup_Specified;
end;

procedure QueuesGroups.SetidParent(Index: Integer; const Astring: string);
begin
  FidParent := Astring;
  FidParent_Specified := True;
end;

function QueuesGroups.idParent_Specified(Index: Integer): boolean;
begin
  Result := FidParent_Specified;
end;

procedure QueuesGroups.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function QueuesGroups.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure ProductsCategories.SetidProductCategory(Index: Integer; const Astring: string);
begin
  FidProductCategory := Astring;
  FidProductCategory_Specified := True;
end;

function ProductsCategories.idProductCategory_Specified(Index: Integer): boolean;
begin
  Result := FidProductCategory_Specified;
end;

procedure ProductsCategories.SetidParent(Index: Integer; const Astring: string);
begin
  FidParent := Astring;
  FidParent_Specified := True;
end;

function ProductsCategories.idParent_Specified(Index: Integer): boolean;
begin
  Result := FidParent_Specified;
end;

procedure ProductsCategories.Settitle(Index: Integer; const Astring: string);
begin
  Ftitle := Astring;
  Ftitle_Specified := True;
end;

function ProductsCategories.title_Specified(Index: Integer): boolean;
begin
  Result := Ftitle_Specified;
end;

procedure ProductsCategories.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function ProductsCategories.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure SurveysQuestions.SetidSurveyQuestion(Index: Integer; const Astring: string);
begin
  FidSurveyQuestion := Astring;
  FidSurveyQuestion_Specified := True;
end;

function SurveysQuestions.idSurveyQuestion_Specified(Index: Integer): boolean;
begin
  Result := FidSurveyQuestion_Specified;
end;

procedure SurveysQuestions.SetidSurvey(Index: Integer; const Astring: string);
begin
  FidSurvey := Astring;
  FidSurvey_Specified := True;
end;

function SurveysQuestions.idSurvey_Specified(Index: Integer): boolean;
begin
  Result := FidSurvey_Specified;
end;

procedure SurveysQuestions.Setquestion(Index: Integer; const Astring: string);
begin
  Fquestion := Astring;
  Fquestion_Specified := True;
end;

function SurveysQuestions.question_Specified(Index: Integer): boolean;
begin
  Result := Fquestion_Specified;
end;

procedure SurveysQuestions.Setanswer1(Index: Integer; const Astring: string);
begin
  Fanswer1 := Astring;
  Fanswer1_Specified := True;
end;

function SurveysQuestions.answer1_Specified(Index: Integer): boolean;
begin
  Result := Fanswer1_Specified;
end;

procedure SurveysQuestions.Setanswer2(Index: Integer; const Astring: string);
begin
  Fanswer2 := Astring;
  Fanswer2_Specified := True;
end;

function SurveysQuestions.answer2_Specified(Index: Integer): boolean;
begin
  Result := Fanswer2_Specified;
end;

procedure SurveysQuestions.Setanswer3(Index: Integer; const Astring: string);
begin
  Fanswer3 := Astring;
  Fanswer3_Specified := True;
end;

function SurveysQuestions.answer3_Specified(Index: Integer): boolean;
begin
  Result := Fanswer3_Specified;
end;

procedure LanguagesResources.SetidLanguage(Index: Integer; const Astring: string);
begin
  FidLanguage := Astring;
  FidLanguage_Specified := True;
end;

function LanguagesResources.idLanguage_Specified(Index: Integer): boolean;
begin
  Result := FidLanguage_Specified;
end;

procedure LanguagesResources.SetidResource(Index: Integer; const Astring: string);
begin
  FidResource := Astring;
  FidResource_Specified := True;
end;

function LanguagesResources.idResource_Specified(Index: Integer): boolean;
begin
  Result := FidResource_Specified;
end;

procedure LanguagesResources.Setlabel_(Index: Integer; const Astring: string);
begin
  Flabel_ := Astring;
  Flabel__Specified := True;
end;

function LanguagesResources.label__Specified(Index: Integer): boolean;
begin
  Result := Flabel__Specified;
end;

procedure LanguagesResources.SetlabelExtra(Index: Integer; const Astring: string);
begin
  FlabelExtra := Astring;
  FlabelExtra_Specified := True;
end;

function LanguagesResources.labelExtra_Specified(Index: Integer): boolean;
begin
  Result := FlabelExtra_Specified;
end;

procedure LanguagesResources.Sethelp(Index: Integer; const Astring: string);
begin
  Fhelp := Astring;
  Fhelp_Specified := True;
end;

function LanguagesResources.help_Specified(Index: Integer): boolean;
begin
  Result := Fhelp_Specified;
end;

procedure LanguagesResources.SethelpExtra(Index: Integer; const Astring: string);
begin
  FhelpExtra := Astring;
  FhelpExtra_Specified := True;
end;

function LanguagesResources.helpExtra_Specified(Index: Integer): boolean;
begin
  Result := FhelpExtra_Specified;
end;

procedure ProductsPositionsRelations.SetidProductPositionRelations(Index: Integer; const Astring: string);
begin
  FidProductPositionRelations := Astring;
  FidProductPositionRelations_Specified := True;
end;

function ProductsPositionsRelations.idProductPositionRelations_Specified(Index: Integer): boolean;
begin
  Result := FidProductPositionRelations_Specified;
end;

procedure ProductsPositionsRelations.SetidProductPosition(Index: Integer; const Astring: string);
begin
  FidProductPosition := Astring;
  FidProductPosition_Specified := True;
end;

function ProductsPositionsRelations.idProductPosition_Specified(Index: Integer): boolean;
begin
  Result := FidProductPosition_Specified;
end;

procedure ProductsPositionsRelations.SetidProduct(Index: Integer; const Astring: string);
begin
  FidProduct := Astring;
  FidProduct_Specified := True;
end;

function ProductsPositionsRelations.idProduct_Specified(Index: Integer): boolean;
begin
  Result := FidProduct_Specified;
end;

procedure Queues.SetidQueue(Index: Integer; const Astring: string);
begin
  FidQueue := Astring;
  FidQueue_Specified := True;
end;

function Queues.idQueue_Specified(Index: Integer): boolean;
begin
  Result := FidQueue_Specified;
end;

procedure Queues.SetidQueueGroup(Index: Integer; const Astring: string);
begin
  FidQueueGroup := Astring;
  FidQueueGroup_Specified := True;
end;

function Queues.idQueueGroup_Specified(Index: Integer): boolean;
begin
  Result := FidQueueGroup_Specified;
end;

procedure Queues.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function Queues.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure Queues.Setplace(Index: Integer; const Astring: string);
begin
  Fplace := Astring;
  Fplace_Specified := True;
end;

function Queues.place_Specified(Index: Integer): boolean;
begin
  Result := Fplace_Specified;
end;

procedure Queues.Setcolor(Index: Integer; const Astring: string);
begin
  Fcolor := Astring;
  Fcolor_Specified := True;
end;

function Queues.color_Specified(Index: Integer): boolean;
begin
  Result := Fcolor_Specified;
end;

procedure Queues.Setletter(Index: Integer; const Astring: string);
begin
  Fletter := Astring;
  Fletter_Specified := True;
end;

function Queues.letter_Specified(Index: Integer): boolean;
begin
  Result := Fletter_Specified;
end;

procedure ProductsPositions.SetidProductPosition(Index: Integer; const Astring: string);
begin
  FidProductPosition := Astring;
  FidProductPosition_Specified := True;
end;

function ProductsPositions.idProductPosition_Specified(Index: Integer): boolean;
begin
  Result := FidProductPosition_Specified;
end;

procedure ProductsPositions.Settitle(Index: Integer; const Astring: string);
begin
  Ftitle := Astring;
  Ftitle_Specified := True;
end;

function ProductsPositions.title_Specified(Index: Integer): boolean;
begin
  Result := Ftitle_Specified;
end;

procedure Channels.SetidChannel(Index: Integer; const Astring: string);
begin
  FidChannel := Astring;
  FidChannel_Specified := True;
end;

function Channels.idChannel_Specified(Index: Integer): boolean;
begin
  Result := FidChannel_Specified;
end;

procedure Channels.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function Channels.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure Channels.Seturl(Index: Integer; const Astring: string);
begin
  Furl := Astring;
  Furl_Specified := True;
end;

function Channels.url_Specified(Index: Integer): boolean;
begin
  Result := Furl_Specified;
end;

procedure ChannelsCameras.SetidChannel(Index: Integer; const Astring: string);
begin
  FidChannel := Astring;
  FidChannel_Specified := True;
end;

function ChannelsCameras.idChannel_Specified(Index: Integer): boolean;
begin
  Result := FidChannel_Specified;
end;

procedure ChannelsCameras.Setconfiguration(Index: Integer; const Astring: string);
begin
  Fconfiguration := Astring;
  Fconfiguration_Specified := True;
end;

function ChannelsCameras.configuration_Specified(Index: Integer): boolean;
begin
  Result := Fconfiguration_Specified;
end;

destructor SurveysAnswers.Destroy;
begin
  System.SysUtils.FreeAndNil(FansweredDate);
  System.SysUtils.FreeAndNil(FansweredTime);
  inherited Destroy;
end;

procedure SurveysAnswers.SetidSurverAnswer(Index: Integer; const Astring: string);
begin
  FidSurverAnswer := Astring;
  FidSurverAnswer_Specified := True;
end;

function SurveysAnswers.idSurverAnswer_Specified(Index: Integer): boolean;
begin
  Result := FidSurverAnswer_Specified;
end;

procedure SurveysAnswers.SetidSurveyQuestion(Index: Integer; const Astring: string);
begin
  FidSurveyQuestion := Astring;
  FidSurveyQuestion_Specified := True;
end;

function SurveysAnswers.idSurveyQuestion_Specified(Index: Integer): boolean;
begin
  Result := FidSurveyQuestion_Specified;
end;

procedure SurveysAnswers.SetidPlayer(Index: Integer; const Astring: string);
begin
  FidPlayer := Astring;
  FidPlayer_Specified := True;
end;

function SurveysAnswers.idPlayer_Specified(Index: Integer): boolean;
begin
  Result := FidPlayer_Specified;
end;

procedure SurveysAnswers.SetuserName(Index: Integer; const Astring: string);
begin
  FuserName := Astring;
  FuserName_Specified := True;
end;

function SurveysAnswers.userName_Specified(Index: Integer): boolean;
begin
  Result := FuserName_Specified;
end;

procedure SurveysAnswers.SetidUser(Index: Integer; const Astring: string);
begin
  FidUser := Astring;
  FidUser_Specified := True;
end;

function SurveysAnswers.idUser_Specified(Index: Integer): boolean;
begin
  Result := FidUser_Specified;
end;

destructor Users.Destroy;
begin
  System.SysUtils.FreeAndNil(FpinCodeExpirationDate);
  System.SysUtils.FreeAndNil(FlastBadLogin);
  System.SysUtils.FreeAndNil(FsocialDate);
  inherited Destroy;
end;

procedure Users.SetidUser(Index: Integer; const Astring: string);
begin
  FidUser := Astring;
  FidUser_Specified := True;
end;

function Users.idUser_Specified(Index: Integer): boolean;
begin
  Result := FidUser_Specified;
end;

procedure Users.SetidCompany(Index: Integer; const Astring: string);
begin
  FidCompany := Astring;
  FidCompany_Specified := True;
end;

function Users.idCompany_Specified(Index: Integer): boolean;
begin
  Result := FidCompany_Specified;
end;

procedure Users.SetfirstName(Index: Integer; const Astring: string);
begin
  FfirstName := Astring;
  FfirstName_Specified := True;
end;

function Users.firstName_Specified(Index: Integer): boolean;
begin
  Result := FfirstName_Specified;
end;

procedure Users.SetlastName(Index: Integer; const Astring: string);
begin
  FlastName := Astring;
  FlastName_Specified := True;
end;

function Users.lastName_Specified(Index: Integer): boolean;
begin
  Result := FlastName_Specified;
end;

procedure Users.Setemail(Index: Integer; const Astring: string);
begin
  Femail := Astring;
  Femail_Specified := True;
end;

function Users.email_Specified(Index: Integer): boolean;
begin
  Result := Femail_Specified;
end;

procedure Users.Setbirthday(Index: Integer; const Astring: string);
begin
  Fbirthday := Astring;
  Fbirthday_Specified := True;
end;

function Users.birthday_Specified(Index: Integer): boolean;
begin
  Result := Fbirthday_Specified;
end;

procedure Users.SetregistrationDate(Index: Integer; const Astring: string);
begin
  FregistrationDate := Astring;
  FregistrationDate_Specified := True;
end;

function Users.registrationDate_Specified(Index: Integer): boolean;
begin
  Result := FregistrationDate_Specified;
end;

procedure Users.Setphone(Index: Integer; const Astring: string);
begin
  Fphone := Astring;
  Fphone_Specified := True;
end;

function Users.phone_Specified(Index: Integer): boolean;
begin
  Result := Fphone_Specified;
end;

procedure Users.Setmobile(Index: Integer; const Astring: string);
begin
  Fmobile := Astring;
  Fmobile_Specified := True;
end;

function Users.mobile_Specified(Index: Integer): boolean;
begin
  Result := Fmobile_Specified;
end;

procedure Users.Setpassword(Index: Integer; const Astring: string);
begin
  Fpassword := Astring;
  Fpassword_Specified := True;
end;

function Users.password_Specified(Index: Integer): boolean;
begin
  Result := Fpassword_Specified;
end;

procedure Users.SetpinCode(Index: Integer; const Astring: string);
begin
  FpinCode := Astring;
  FpinCode_Specified := True;
end;

function Users.pinCode_Specified(Index: Integer): boolean;
begin
  Result := FpinCode_Specified;
end;

procedure Users.Setdni(Index: Integer; const Astring: string);
begin
  Fdni := Astring;
  Fdni_Specified := True;
end;

function Users.dni_Specified(Index: Integer): boolean;
begin
  Result := Fdni_Specified;
end;

procedure Users.SetidProfessional(Index: Integer; const Astring: string);
begin
  FidProfessional := Astring;
  FidProfessional_Specified := True;
end;

function Users.idProfessional_Specified(Index: Integer): boolean;
begin
  Result := FidProfessional_Specified;
end;

procedure Users.SetidSocial(Index: Integer; const Astring: string);
begin
  FidSocial := Astring;
  FidSocial_Specified := True;
end;

function Users.idSocial_Specified(Index: Integer): boolean;
begin
  Result := FidSocial_Specified;
end;

procedure Users.SetsocialNumber(Index: Integer; const Astring: string);
begin
  FsocialNumber := Astring;
  FsocialNumber_Specified := True;
end;

function Users.socialNumber_Specified(Index: Integer): boolean;
begin
  Result := FsocialNumber_Specified;
end;

procedure Users.SetsocialPlan(Index: Integer; const Astring: string);
begin
  FsocialPlan := Astring;
  FsocialPlan_Specified := True;
end;

function Users.socialPlan_Specified(Index: Integer): boolean;
begin
  Result := FsocialPlan_Specified;
end;

procedure Users.Setcity(Index: Integer; const Astring: string);
begin
  Fcity := Astring;
  Fcity_Specified := True;
end;

function Users.city_Specified(Index: Integer): boolean;
begin
  Result := Fcity_Specified;
end;

procedure Users.Setaddress(Index: Integer; const Astring: string);
begin
  Faddress := Astring;
  Faddress_Specified := True;
end;

function Users.address_Specified(Index: Integer): boolean;
begin
  Result := Faddress_Specified;
end;

destructor Products.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FlanguagesResources)-1 do
    System.SysUtils.FreeAndNil(FlanguagesResources[I]);
  System.SetLength(FlanguagesResources, 0);
  System.SysUtils.FreeAndNil(Fcategory);
  inherited Destroy;
end;

procedure Products.SetidProduct(Index: Integer; const Astring: string);
begin
  FidProduct := Astring;
  FidProduct_Specified := True;
end;

function Products.idProduct_Specified(Index: Integer): boolean;
begin
  Result := FidProduct_Specified;
end;

procedure Products.SetidProductCategory(Index: Integer; const Astring: string);
begin
  FidProductCategory := Astring;
  FidProductCategory_Specified := True;
end;

function Products.idProductCategory_Specified(Index: Integer): boolean;
begin
  Result := FidProductCategory_Specified;
end;

procedure Products.SetidProductBrand(Index: Integer; const Astring: string);
begin
  FidProductBrand := Astring;
  FidProductBrand_Specified := True;
end;

function Products.idProductBrand_Specified(Index: Integer): boolean;
begin
  Result := FidProductBrand_Specified;
end;

procedure Products.Setbrand(Index: Integer; const Astring: string);
begin
  Fbrand := Astring;
  Fbrand_Specified := True;
end;

function Products.brand_Specified(Index: Integer): boolean;
begin
  Result := Fbrand_Specified;
end;

procedure Products.SetbrandType(Index: Integer; const Astring: string);
begin
  FbrandType := Astring;
  FbrandType_Specified := True;
end;

function Products.brandType_Specified(Index: Integer): boolean;
begin
  Result := FbrandType_Specified;
end;

procedure Products.SetbrandStyle(Index: Integer; const Astring: string);
begin
  FbrandStyle := Astring;
  FbrandStyle_Specified := True;
end;

function Products.brandStyle_Specified(Index: Integer): boolean;
begin
  Result := FbrandStyle_Specified;
end;

procedure Products.SetbrandStyleExtra(Index: Integer; const Astring: string);
begin
  FbrandStyleExtra := Astring;
  FbrandStyleExtra_Specified := True;
end;

function Products.brandStyleExtra_Specified(Index: Integer): boolean;
begin
  Result := FbrandStyleExtra_Specified;
end;

procedure Products.Setrelated01(Index: Integer; const Astring: string);
begin
  Frelated01 := Astring;
  Frelated01_Specified := True;
end;

function Products.related01_Specified(Index: Integer): boolean;
begin
  Result := Frelated01_Specified;
end;

procedure Products.Setrelated02(Index: Integer; const Astring: string);
begin
  Frelated02 := Astring;
  Frelated02_Specified := True;
end;

function Products.related02_Specified(Index: Integer): boolean;
begin
  Result := Frelated02_Specified;
end;

procedure Products.Setrelated03(Index: Integer; const Astring: string);
begin
  Frelated03 := Astring;
  Frelated03_Specified := True;
end;

function Products.related03_Specified(Index: Integer): boolean;
begin
  Result := Frelated03_Specified;
end;

procedure Products.SetbarCode01(Index: Integer; const Astring: string);
begin
  FbarCode01 := Astring;
  FbarCode01_Specified := True;
end;

function Products.barCode01_Specified(Index: Integer): boolean;
begin
  Result := FbarCode01_Specified;
end;

procedure Products.SetbarCode02(Index: Integer; const Astring: string);
begin
  FbarCode02 := Astring;
  FbarCode02_Specified := True;
end;

function Products.barCode02_Specified(Index: Integer): boolean;
begin
  Result := FbarCode02_Specified;
end;

procedure Products.SetbarCode03(Index: Integer; const Astring: string);
begin
  FbarCode03 := Astring;
  FbarCode03_Specified := True;
end;

function Products.barCode03_Specified(Index: Integer): boolean;
begin
  Result := FbarCode03_Specified;
end;

procedure Products.Settitle(Index: Integer; const Astring: string);
begin
  Ftitle := Astring;
  Ftitle_Specified := True;
end;

function Products.title_Specified(Index: Integer): boolean;
begin
  Result := Ftitle_Specified;
end;

procedure Products.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function Products.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure Products.SetidProductGroup(Index: Integer; const Astring: string);
begin
  FidProductGroup := Astring;
  FidProductGroup_Specified := True;
end;

function Products.idProductGroup_Specified(Index: Integer): boolean;
begin
  Result := FidProductGroup_Specified;
end;

procedure Products.Setcategory(Index: Integer; const AProductsCategories: ProductsCategories);
begin
  Fcategory := AProductsCategories;
  Fcategory_Specified := True;
end;

function Products.category_Specified(Index: Integer): boolean;
begin
  Result := Fcategory_Specified;
end;

procedure Products.SetidProductPositionRelations(Index: Integer; const Astring: string);
begin
  FidProductPositionRelations := Astring;
  FidProductPositionRelations_Specified := True;
end;

function Products.idProductPositionRelations_Specified(Index: Integer): boolean;
begin
  Result := FidProductPositionRelations_Specified;
end;

procedure Products.SetlanguagesResources(Index: Integer; const AArrayOfLanguagesResources: ArrayOfLanguagesResources);
begin
  FlanguagesResources := AArrayOfLanguagesResources;
  FlanguagesResources_Specified := True;
end;

function Products.languagesResources_Specified(Index: Integer): boolean;
begin
  Result := FlanguagesResources_Specified;
end;

destructor QueuesShifts.Destroy;
begin
  System.SysUtils.FreeAndNil(FqueueDate);
  inherited Destroy;
end;

procedure QueuesShifts.SetidQueueShift(Index: Integer; const Astring: string);
begin
  FidQueueShift := Astring;
  FidQueueShift_Specified := True;
end;

function QueuesShifts.idQueueShift_Specified(Index: Integer): boolean;
begin
  Result := FidQueueShift_Specified;
end;

procedure QueuesShifts.SetidQueue(Index: Integer; const Astring: string);
begin
  FidQueue := Astring;
  FidQueue_Specified := True;
end;

function QueuesShifts.idQueue_Specified(Index: Integer): boolean;
begin
  Result := FidQueue_Specified;
end;

procedure QueuesShifts.SetidParentQueue(Index: Integer; const Astring: string);
begin
  FidParentQueue := Astring;
  FidParentQueue_Specified := True;
end;

function QueuesShifts.idParentQueue_Specified(Index: Integer): boolean;
begin
  Result := FidParentQueue_Specified;
end;

procedure QueuesShifts.Setletter(Index: Integer; const Astring: string);
begin
  Fletter := Astring;
  Fletter_Specified := True;
end;

function QueuesShifts.letter_Specified(Index: Integer): boolean;
begin
  Result := Fletter_Specified;
end;

procedure QueuesShifts.SetidQueueCustomer(Index: Integer; const Astring: string);
begin
  FidQueueCustomer := Astring;
  FidQueueCustomer_Specified := True;
end;

function QueuesShifts.idQueueCustomer_Specified(Index: Integer): boolean;
begin
  Result := FidQueueCustomer_Specified;
end;

procedure QueuesShifts.SetidUser(Index: Integer; const Astring: string);
begin
  FidUser := Astring;
  FidUser_Specified := True;
end;

function QueuesShifts.idUser_Specified(Index: Integer): boolean;
begin
  Result := FidUser_Specified;
end;

procedure QueuesShifts.SetidPlayer(Index: Integer; const Astring: string);
begin
  FidPlayer := Astring;
  FidPlayer_Specified := True;
end;

function QueuesShifts.idPlayer_Specified(Index: Integer): boolean;
begin
  Result := FidPlayer_Specified;
end;

procedure QueuesShifts.Setreason(Index: Integer; const Astring: string);
begin
  Freason := Astring;
  Freason_Specified := True;
end;

function QueuesShifts.reason_Specified(Index: Integer): boolean;
begin
  Result := Freason_Specified;
end;

procedure PlayersGroups.SetidPlayerGroup(Index: Integer; const Astring: string);
begin
  FidPlayerGroup := Astring;
  FidPlayerGroup_Specified := True;
end;

function PlayersGroups.idPlayerGroup_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerGroup_Specified;
end;

procedure PlayersGroups.SetidParent(Index: Integer; const Astring: string);
begin
  FidParent := Astring;
  FidParent_Specified := True;
end;

function PlayersGroups.idParent_Specified(Index: Integer): boolean;
begin
  Result := FidParent_Specified;
end;

procedure PlayersGroups.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function PlayersGroups.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure PlayersDesigns.SetidPlayerDesign(Index: Integer; const Astring: string);
begin
  FidPlayerDesign := Astring;
  FidPlayerDesign_Specified := True;
end;

function PlayersDesigns.idPlayerDesign_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerDesign_Specified;
end;

procedure PlayersDesigns.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function PlayersDesigns.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure PlayersDesigns.SetimageBase64(Index: Integer; const Astring: string);
begin
  FimageBase64 := Astring;
  FimageBase64_Specified := True;
end;

function PlayersDesigns.imageBase64_Specified(Index: Integer): boolean;
begin
  Result := FimageBase64_Specified;
end;

destructor LicenseEntity.Destroy;
begin
  System.SysUtils.FreeAndNil(FCreateDateTime);
  inherited Destroy;
end;

procedure LicenseEntity.SetAppName(Index: Integer; const Astring: string);
begin
  FAppName := Astring;
  FAppName_Specified := True;
end;

function LicenseEntity.AppName_Specified(Index: Integer): boolean;
begin
  Result := FAppName_Specified;
end;

procedure LicenseEntity.SetUID(Index: Integer; const Astring: string);
begin
  FUID := Astring;
  FUID_Specified := True;
end;

function LicenseEntity.UID_Specified(Index: Integer): boolean;
begin
  Result := FUID_Specified;
end;

destructor Surveys.Destroy;
begin
  System.SysUtils.FreeAndNil(FstartDate);
  System.SysUtils.FreeAndNil(FendDate);
  inherited Destroy;
end;

procedure Surveys.SetidSurvey(Index: Integer; const Astring: string);
begin
  FidSurvey := Astring;
  FidSurvey_Specified := True;
end;

function Surveys.idSurvey_Specified(Index: Integer): boolean;
begin
  Result := FidSurvey_Specified;
end;

procedure Surveys.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function Surveys.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

destructor Players.Destroy;
begin
  System.SysUtils.FreeAndNil(FlastReport);
  inherited Destroy;
end;

procedure Players.SetidPlayer(Index: Integer; const Astring: string);
begin
  FidPlayer := Astring;
  FidPlayer_Specified := True;
end;

function Players.idPlayer_Specified(Index: Integer): boolean;
begin
  Result := FidPlayer_Specified;
end;

procedure Players.SetidPlayerGroup(Index: Integer; const Astring: string);
begin
  FidPlayerGroup := Astring;
  FidPlayerGroup_Specified := True;
end;

function Players.idPlayerGroup_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerGroup_Specified;
end;

procedure Players.Setip(Index: Integer; const Astring: string);
begin
  Fip := Astring;
  Fip_Specified := True;
end;

function Players.ip_Specified(Index: Integer): boolean;
begin
  Result := Fip_Specified;
end;

procedure Players.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function Players.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure Players.Setplace(Index: Integer; const Astring: string);
begin
  Fplace := Astring;
  Fplace_Specified := True;
end;

function Players.place_Specified(Index: Integer): boolean;
begin
  Result := Fplace_Specified;
end;

procedure Players.Setmodel(Index: Integer; const Astring: string);
begin
  Fmodel := Astring;
  Fmodel_Specified := True;
end;

function Players.model_Specified(Index: Integer): boolean;
begin
  Result := Fmodel_Specified;
end;

procedure Players.SetlastUpdate(Index: Integer; const Astring: string);
begin
  FlastUpdate := Astring;
  FlastUpdate_Specified := True;
end;

function Players.lastUpdate_Specified(Index: Integer): boolean;
begin
  Result := FlastUpdate_Specified;
end;

procedure Players.SetscreenSaverIdPlayerDesign(Index: Integer; const Astring: string);
begin
  FscreenSaverIdPlayerDesign := Astring;
  FscreenSaverIdPlayerDesign_Specified := True;
end;

function Players.screenSaverIdPlayerDesign_Specified(Index: Integer): boolean;
begin
  Result := FscreenSaverIdPlayerDesign_Specified;
end;

destructor PlayersTimeLine.Destroy;
begin
  System.SysUtils.FreeAndNil(FdateReleased);
  System.SysUtils.FreeAndNil(FscheduleStartDate);
  System.SysUtils.FreeAndNil(FscheduleEndDate);
  inherited Destroy;
end;

procedure PlayersTimeLine.SetidPlayerTimeLine(Index: Integer; const Astring: string);
begin
  FidPlayerTimeLine := Astring;
  FidPlayerTimeLine_Specified := True;
end;

function PlayersTimeLine.idPlayerTimeLine_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerTimeLine_Specified;
end;

procedure PlayersTimeLine.SetidPlayerDesign(Index: Integer; const Astring: string);
begin
  FidPlayerDesign := Astring;
  FidPlayerDesign_Specified := True;
end;

function PlayersTimeLine.idPlayerDesign_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerDesign_Specified;
end;

procedure PlayersTimeLine.SetidPlayerGroup(Index: Integer; const Astring: string);
begin
  FidPlayerGroup := Astring;
  FidPlayerGroup_Specified := True;
end;

function PlayersTimeLine.idPlayerGroup_Specified(Index: Integer): boolean;
begin
  Result := FidPlayerGroup_Specified;
end;

procedure PlayersTimeLine.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function PlayersTimeLine.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

initialization
  { ManagerSoap }
  InvRegistry.RegisterInterface(TypeInfo(ManagerSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ManagerSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ManagerSoap), ioDocument);
  { ManagerSoap.HelloWorld }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'HelloWorld', '',
                                 '[ReturnName="HelloWorldResult"]', IS_OPTN);
  { ManagerSoap.GetMaxRequestLength }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetMaxRequestLength', '',
                                 '[ReturnName="GetMaxRequestLengthResult"]');
  { ManagerSoap.DownloadChunk }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'DownloadChunk', '',
                                 '[ReturnName="DownloadChunkResult"]', IS_OPTN);
  { ManagerSoap.GetFileSize }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetFileSize', '',
                                 '[ReturnName="GetFileSizeResult"]');
  { ManagerSoap.GetFilesList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetFilesList', '',
                                 '[ReturnName="GetFilesListResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetFilesList', 'GetFilesListResult', '',
                                '[ArrayItemName="string"]');
  { ManagerSoap.CheckFileHash }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'CheckFileHash', '',
                                 '[ReturnName="CheckFileHashResult"]', IS_OPTN);
  { ManagerSoap.GetUpdates }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetUpdates', '',
                                 '[ReturnName="GetUpdatesResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetUpdates', 'GetUpdatesResult', '',
                                '[ArrayItemName="anyType"]');
  { ManagerSoap.GetPlayersTimeLine }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayersTimeLine', '',
                                 '[ReturnName="GetPlayersTimeLineResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetPlayersTimeLine', 'GetPlayersTimeLineResult', '',
                                '[ArrayItemName="PlayersTimeLine"]');
  { ManagerSoap.GetPlayersTimeLineByIdPlayer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayersTimeLineByIdPlayer', '',
                                 '[ReturnName="GetPlayersTimeLineByIdPlayerResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetPlayersTimeLineByIdPlayer', 'GetPlayersTimeLineByIdPlayerResult', '',
                                '[ArrayItemName="PlayersTimeLine"]');
  { ManagerSoap.GetLicense }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetLicense', '',
                                 '[ReturnName="GetLicenseResult"]', IS_OPTN);
  { ManagerSoap.GetPlayersDesigns }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayersDesigns', '',
                                 '[ReturnName="GetPlayersDesignsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetPlayersDesigns', 'GetPlayersDesignsResult', '',
                                '[ArrayItemName="PlayersDesigns"]');
  { ManagerSoap.SaveDesign }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'SaveDesign', '',
                                 '[ReturnName="SaveDesignResult"]', IS_OPTN);
  { ManagerSoap.LoginUser }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'LoginUser', '',
                                 '[ReturnName="LoginUserResult"]');
  { ManagerSoap.SetLog }
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'SetLog', 'type_', 'type', '');
  { ManagerSoap.RegisterPlayer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'RegisterPlayer', '',
                                 '[ReturnName="RegisterPlayerResult"]', IS_OPTN);
  { ManagerSoap.PlayerStatus }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'PlayerStatus', '',
                                 '[ReturnName="PlayerStatusResult"]', IS_OPTN);
  { ManagerSoap.GetPlayers }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayers', '',
                                 '[ReturnName="GetPlayersResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetPlayers', 'GetPlayersResult', '',
                                '[ArrayItemName="Players"]');
  { ManagerSoap.GetPlayer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayer', '',
                                 '[ReturnName="GetPlayerResult"]', IS_OPTN);
  { ManagerSoap.GetCurrentSurvey }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetCurrentSurvey', '',
                                 '[ReturnName="GetCurrentSurveyResult"]', IS_OPTN);
  { ManagerSoap.GetSurveyQuestions }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetSurveyQuestions', '',
                                 '[ReturnName="GetSurveyQuestionsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetSurveyQuestions', 'GetSurveyQuestionsResult', '',
                                '[ArrayItemName="SurveysQuestions"]');
  { ManagerSoap.GetLanguagesResources }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetLanguagesResources', '',
                                 '[ReturnName="GetLanguagesResourcesResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetLanguagesResources', 'GetLanguagesResourcesResult', '',
                                '[ArrayItemName="LanguagesResources"]');
  { ManagerSoap.GetProducts }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetProducts', '',
                                 '[ReturnName="GetProductsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetProducts', 'GetProductsResult', '',
                                '[ArrayItemName="Products"]');
  { ManagerSoap.GetProductsPositionsRelations }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetProductsPositionsRelations', '',
                                 '[ReturnName="GetProductsPositionsRelationsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetProductsPositionsRelations', 'GetProductsPositionsRelationsResult', '',
                                '[ArrayItemName="ProductsPositionsRelations"]');
  { ManagerSoap.GetProductsPositions }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetProductsPositions', '',
                                 '[ReturnName="GetProductsPositionsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetProductsPositions', 'GetProductsPositionsResult', '',
                                '[ArrayItemName="ProductsPositions"]');
  { ManagerSoap.GetQueuesPending }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetQueuesPending', '',
                                 '[ReturnName="GetQueuesPendingResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetQueuesPending', 'GetQueuesPendingResult', '',
                                '[ArrayItemName="QueuesShifts"]');
  { ManagerSoap.GetQueuesShiftsByIdPlayer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetQueuesShiftsByIdPlayer', '',
                                 '[ReturnName="GetQueuesShiftsByIdPlayerResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetQueuesShiftsByIdPlayer', 'GetQueuesShiftsByIdPlayerResult', '',
                                '[ArrayItemName="QueuesShifts"]');
  { ManagerSoap.GetQueuesByIdPlayer }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetQueuesByIdPlayer', '',
                                 '[ReturnName="GetQueuesByIdPlayerResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetQueuesByIdPlayer', 'GetQueuesByIdPlayerResult', '',
                                '[ArrayItemName="Queues"]');
  { ManagerSoap.GetChannels }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetChannels', '',
                                 '[ReturnName="GetChannelsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetChannels', 'GetChannelsResult', '',
                                '[ArrayItemName="Channels"]');
  { ManagerSoap.GetChannelsCameras }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetChannelsCameras', '',
                                 '[ReturnName="GetChannelsCamerasResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetChannelsCameras', 'GetChannelsCamerasResult', '',
                                '[ArrayItemName="ChannelsCameras"]');
  { ManagerSoap.GetQueues }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetQueues', '',
                                 '[ReturnName="GetQueuesResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetQueues', 'GetQueuesResult', '',
                                '[ArrayItemName="Queues"]');
  { ManagerSoap.GetPlayersGroups }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetPlayersGroups', '',
                                 '[ReturnName="GetPlayersGroupsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetPlayersGroups', 'GetPlayersGroupsResult', '',
                                '[ArrayItemName="PlayersGroups"]');
  { ManagerSoap.GetUsers }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetUsers', '',
                                 '[ReturnName="GetUsersResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetUsers', 'GetUsersResult', '',
                                '[ArrayItemName="Users"]');
  { ManagerSoap.GetUserByDNI }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetUserByDNI', '',
                                 '[ReturnName="GetUserByDNIResult"]', IS_OPTN);
  { ManagerSoap.GetUserByFirstName }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetUserByFirstName', '',
                                 '[ReturnName="GetUserByFirstNameResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetUserByFirstName', 'name_', 'name', '');
  { ManagerSoap.GetUserByLastName }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetUserByLastName', '',
                                 '[ReturnName="GetUserByLastNameResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetUserByLastName', 'name_', 'name', '');
  { ManagerSoap.GetQueuesGroups }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetQueuesGroups', '',
                                 '[ReturnName="GetQueuesGroupsResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetQueuesGroups', 'GetQueuesGroupsResult', '',
                                '[ArrayItemName="QueuesGroups"]');
  { ManagerSoap.IsQueueGroupHidden }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'IsQueueGroupHidden', '',
                                 '[ReturnName="IsQueueGroupHiddenResult"]');
  { ManagerSoap.UpdateQueueShift }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'UpdateQueueShift', '',
                                 '[ReturnName="UpdateQueueShiftResult"]', IS_OPTN);
  { ManagerSoap.GetAllMedia }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetAllMedia', '',
                                 '[ReturnName="GetAllMediaResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetAllMedia', 'GetAllMediaResult', '',
                                '[ArrayItemName="FileNode"]');
  { ManagerSoap.GetAllGames }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetAllGames', '',
                                 '[ReturnName="GetAllGamesResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetAllGames', 'GetAllGamesResult', '',
                                '[ArrayItemName="FileNode"]');
  { ManagerSoap.GetAllFolderGames }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'GetAllFolderGames', '',
                                 '[ReturnName="GetAllFolderGamesResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ManagerSoap), 'GetAllFolderGames', 'GetAllFolderGamesResult', '',
                                '[ArrayItemName="FileNode"]');
  { ManagerSoap.CheckSyncFileHash }
  InvRegistry.RegisterMethodInfo(TypeInfo(ManagerSoap), 'CheckSyncFileHash', '',
                                 '[ReturnName="CheckSyncFileHashResult"]', IS_OPTN);
  RemClassRegistry.RegisterXSInfo(TypeInfo(QUEUE_PRIORITY), 'http://tempuri.org/', 'QUEUE_PRIORITY');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CATEGORY_TYPES), 'http://tempuri.org/', 'CATEGORY_TYPES');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLanguagesResources), 'http://tempuri.org/', 'ArrayOfLanguagesResources');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://tempuri.org/', 'ArrayOfString');
  RemClassRegistry.RegisterXSClass(FileNode, 'http://tempuri.org/', 'FileNode');
  RemClassRegistry.RegisterXSClass(QueuesGroups, 'http://tempuri.org/', 'QueuesGroups');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(QueuesGroups), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(ProductsCategories, 'http://tempuri.org/', 'ProductsCategories');
  RemClassRegistry.RegisterXSClass(SurveysQuestions, 'http://tempuri.org/', 'SurveysQuestions');
  RemClassRegistry.RegisterXSClass(LanguagesResources, 'http://tempuri.org/', 'LanguagesResources');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LanguagesResources), 'label_', '[ExtName="label"]');
  RemClassRegistry.RegisterXSClass(ProductsPositionsRelations, 'http://tempuri.org/', 'ProductsPositionsRelations');
  RemClassRegistry.RegisterXSClass(Queues, 'http://tempuri.org/', 'Queues');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Queues), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(ProductsPositions, 'http://tempuri.org/', 'ProductsPositions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfAnyType), 'http://tempuri.org/', 'ArrayOfAnyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ACCESS_LEVEL), 'http://tempuri.org/', 'ACCESS_LEVEL');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CHANNEL_CAMERA_TYPE), 'http://tempuri.org/', 'CHANNEL_CAMERA_TYPE');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CHANNEL_TYPE), 'http://tempuri.org/', 'CHANNEL_TYPE');
  RemClassRegistry.RegisterXSClass(Channels, 'http://tempuri.org/', 'Channels');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Channels), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(ChannelsCameras, 'http://tempuri.org/', 'ChannelsCameras');
  RemClassRegistry.RegisterXSClass(SurveysAnswers, 'http://tempuri.org/', 'SurveysAnswers');
  RemClassRegistry.RegisterXSClass(Users, 'http://tempuri.org/', 'Users');
  RemClassRegistry.RegisterXSClass(Products, 'http://tempuri.org/', 'Products');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Products), 'languagesResources', '[ArrayItemName="LanguagesResources"]');
  RemClassRegistry.RegisterXSClass(QueuesShifts, 'http://tempuri.org/', 'QueuesShifts');
  RemClassRegistry.RegisterXSClass(PlayersGroups, 'http://tempuri.org/', 'PlayersGroups');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PlayersGroups), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueues), 'http://tempuri.org/', 'ArrayOfQueues');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfChannels), 'http://tempuri.org/', 'ArrayOfChannels');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfChannelsCameras), 'http://tempuri.org/', 'ArrayOfChannelsCameras');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueuesShifts), 'http://tempuri.org/', 'ArrayOfQueuesShifts');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProducts), 'http://tempuri.org/', 'ArrayOfProducts');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProductsPositionsRelations), 'http://tempuri.org/', 'ArrayOfProductsPositionsRelations');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProductsPositions), 'http://tempuri.org/', 'ArrayOfProductsPositions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PlayersLogType), 'http://tempuri.org/', 'PlayersLogType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfFileNode), 'http://tempuri.org/', 'ArrayOfFileNode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersGroups), 'http://tempuri.org/', 'ArrayOfPlayersGroups');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfUsers), 'http://tempuri.org/', 'ArrayOfUsers');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueuesGroups), 'http://tempuri.org/', 'ArrayOfQueuesGroups');
  RemClassRegistry.RegisterXSClass(PlayersDesigns, 'http://tempuri.org/', 'PlayersDesigns');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LicenseTypes), 'http://tempuri.org/', 'LicenseTypes');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LicenseTypes), 'Single_', 'Single');
  RemClassRegistry.RegisterXSClass(LicenseEntity, 'http://tempuri.org/', 'LicenseEntity');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LicenseEntity), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SCREEN_SAVER_TYPE), 'http://tempuri.org/', 'SCREEN_SAVER_TYPE');
  RemClassRegistry.RegisterXSClass(Surveys, 'http://tempuri.org/', 'Surveys');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Surveys), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EQUIPMENT_TYPE), 'http://tempuri.org/', 'EQUIPMENT_TYPE');
  RemClassRegistry.RegisterXSClass(Players, 'http://tempuri.org/', 'Players');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Players), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersDesigns), 'http://tempuri.org/', 'ArrayOfPlayersDesigns');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayers), 'http://tempuri.org/', 'ArrayOfPlayers');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSurveysQuestions), 'http://tempuri.org/', 'ArrayOfSurveysQuestions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersTimeLine), 'http://tempuri.org/', 'ArrayOfPlayersTimeLine');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LicenseTypesTecnoSignage), 'http://tempuri.org/', 'LicenseTypesTecnoSignage');
  RemClassRegistry.RegisterXSClass(TecnoSignageLicense, 'http://tempuri.org/', 'TecnoSignageLicense');
  RemClassRegistry.RegisterXSClass(PlayersTimeLine, 'http://tempuri.org/', 'PlayersTimeLine');

end.