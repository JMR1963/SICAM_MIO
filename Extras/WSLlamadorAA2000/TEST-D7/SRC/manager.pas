// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://server-llamador/ws/manager.asmx?WSDL
// Encoding : utf-8
// Version  : 1.0
// (01/02/2021 09:36:08 - 1.33.2.5)
// ************************************************************************ //

unit manager;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:long            - "http://www.w3.org/2001/XMLSchema"
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:                - "http://tempuri.org/"
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:double          - "http://www.w3.org/2001/XMLSchema"

  ArrayOfAnyType       = class;                 { "http://tempuri.org/"[A] }
  PlayersTimeLine      = class;                 { "http://tempuri.org/" }
  LicenseEntity        = class;                 { "http://tempuri.org/" }
  TecnoSignageLicense  = class;                 { "http://tempuri.org/" }
  PlayersDesigns       = class;                 { "http://tempuri.org/" }
  Players              = class;                 { "http://tempuri.org/" }
  Surveys              = class;                 { "http://tempuri.org/" }
  SurveysQuestions     = class;                 { "http://tempuri.org/" }
  SurveysAnswers       = class;                 { "http://tempuri.org/" }
  ProductsCategories   = class;                 { "http://tempuri.org/" }
  LanguagesResources   = class;                 { "http://tempuri.org/" }
  Products2            = class;                 { "http://tempuri.org/" }
  ProductsPositionsRelations = class;           { "http://tempuri.org/" }
  ProductsPositions    = class;                 { "http://tempuri.org/" }
  QueuesShifts         = class;                 { "http://tempuri.org/" }
  Queues               = class;                 { "http://tempuri.org/" }
  Channels             = class;                 { "http://tempuri.org/" }
  ChannelsCameras      = class;                 { "http://tempuri.org/" }
  PlayersGroups        = class;                 { "http://tempuri.org/" }
  Users                = class;                 { "http://tempuri.org/" }
  QueuesGroups         = class;                 { "http://tempuri.org/" }
  FileNode             = class;                 { "http://tempuri.org/" }

  { "http://tempuri.org/" }
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

  { "http://tempuri.org/" }
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

  { "http://tempuri.org/" }
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

  { "http://tempuri.org/" }
  QUEUE_PRIORITY = (NORMAL, SILVER, GOLD, BLACK, VIP);

  { "http://tempuri.org/" }
  CATEGORY_TYPES = (FRAGANCE, FOOD, ELECTRONIC, COMPUTERS, HARDWARE, SOFTWARE, SERVICES, MOBILE, OTHERS);

  { "http://tempuri.org/" }
  EQUIPMENT_TYPE = (PLAYER, TOTEM, CALLER);

  { "http://tempuri.org/" }
  SCREEN_SAVER_TYPE = (NONE2, ALL, INDIVIDUAL);

  { "http://tempuri.org/" }
  LicenseTypes = (Unknown, Single, Volume);

  { "http://tempuri.org/" }
  LicenseTypesTecnoSignage = (FREE, STARTER, PREMIUM, ELITE);

  { "http://tempuri.org/" }
  PlayersLogType = (INFO, ERROR, SYNC, OTHER);

  ArrayOfString = array of WideString;          { "http://tempuri.org/" }
  anyType    = array of Variant;                { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ArrayOfAnyType = class(TRemotable)
  private
    FanyType: anyType;
  public
    constructor Create; override;
    function   GetVariantArray(Index: Integer): Variant;
    function   GetVariantArrayLength: Integer;
    property   VariantArray[Index: Integer]: Variant read GetVariantArray; default;
    property   Len: Integer read GetVariantArrayLength;
  published
    property anyType: anyType read FanyType write FanyType;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersTimeLine = class(TRemotable)
  private
    FidPlayerTimeLine: WideString;
    FidPlayerDesign: WideString;
    FidPlayerGroup: WideString;
    FdateReleased: TXSDateTime;
    Fdescription: WideString;
    FisActive: Boolean;
    Fdestination: Integer;
    FscheduleStartDate: TXSDateTime;
    FscheduleStartTime: Double;
    FscheduleEndDate: TXSDateTime;
    FscheduleEndTime: Double;
    FscheduleRepeat: Integer;
    Fday: Integer;
  public
    destructor Destroy; override;
  published
    property idPlayerTimeLine: WideString read FidPlayerTimeLine write FidPlayerTimeLine;
    property idPlayerDesign: WideString read FidPlayerDesign write FidPlayerDesign;
    property idPlayerGroup: WideString read FidPlayerGroup write FidPlayerGroup;
    property dateReleased: TXSDateTime read FdateReleased write FdateReleased;
    property description: WideString read Fdescription write Fdescription;
    property isActive: Boolean read FisActive write FisActive;
    property destination: Integer read Fdestination write Fdestination;
    property scheduleStartDate: TXSDateTime read FscheduleStartDate write FscheduleStartDate;
    property scheduleStartTime: Double read FscheduleStartTime write FscheduleStartTime;
    property scheduleEndDate: TXSDateTime read FscheduleEndDate write FscheduleEndDate;
    property scheduleEndTime: Double read FscheduleEndTime write FscheduleEndTime;
    property scheduleRepeat: Integer read FscheduleRepeat write FscheduleRepeat;
    property day: Integer read Fday write Fday;
  end;

  ArrayOfPlayersTimeLine = array of PlayersTimeLine;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  LicenseEntity = class(TRemotable)
  private
    FAppName: WideString;
    FUID: WideString;
    FType_: LicenseTypes;
    FCreateDateTime: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property AppName: WideString read FAppName write FAppName;
    property UID: WideString read FUID write FUID;
    property Type_: LicenseTypes read FType_ write FType_;
    property CreateDateTime: TXSDateTime read FCreateDateTime write FCreateDateTime;
  end;



  // ************************************************************************ //
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
    property LicenseType: LicenseTypesTecnoSignage read FLicenseType write FLicenseType;
    property EnableQueue: Boolean read FEnableQueue write FEnableQueue;
    property EnableGames: Boolean read FEnableGames write FEnableGames;
    property EnableAppointment: Boolean read FEnableAppointment write FEnableAppointment;
    property EnableProducts: Boolean read FEnableProducts write FEnableProducts;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersDesigns = class(TRemotable)
  private
    FidPlayerDesign: WideString;
    Fdescription: WideString;
    FisEnabled: Boolean;
    FimageBase64: WideString;
  published
    property idPlayerDesign: WideString read FidPlayerDesign write FidPlayerDesign;
    property description: WideString read Fdescription write Fdescription;
    property isEnabled: Boolean read FisEnabled write FisEnabled;
    property imageBase64: WideString read FimageBase64 write FimageBase64;
  end;

  ArrayOfPlayersDesigns = array of PlayersDesigns;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Players = class(TRemotable)
  private
    FidPlayer: WideString;
    FidPlayerGroup: WideString;
    Fip: WideString;
    Fname: WideString;
    Fplace: WideString;
    Fmodel: WideString;
    FequipmentType: EQUIPMENT_TYPE;
    FdiskSpace: Integer;
    FtotalScreens: Integer;
    FlastReport: TXSDateTime;
    FlastUpdate: WideString;
    FscreenSaverTime: Integer;
    FscreenSaverScreens: SCREEN_SAVER_TYPE;
    FscreenSaverIdPlayerDesign: WideString;
  public
    destructor Destroy; override;
  published
    property idPlayer: WideString read FidPlayer write FidPlayer;
    property idPlayerGroup: WideString read FidPlayerGroup write FidPlayerGroup;
    property ip: WideString read Fip write Fip;
    property name: WideString read Fname write Fname;
    property place: WideString read Fplace write Fplace;
    property model: WideString read Fmodel write Fmodel;
    property equipmentType: EQUIPMENT_TYPE read FequipmentType write FequipmentType;
    property diskSpace: Integer read FdiskSpace write FdiskSpace;
    property totalScreens: Integer read FtotalScreens write FtotalScreens;
    property lastReport: TXSDateTime read FlastReport write FlastReport;
    property lastUpdate: WideString read FlastUpdate write FlastUpdate;
    property screenSaverTime: Integer read FscreenSaverTime write FscreenSaverTime;
    property screenSaverScreens: SCREEN_SAVER_TYPE read FscreenSaverScreens write FscreenSaverScreens;
    property screenSaverIdPlayerDesign: WideString read FscreenSaverIdPlayerDesign write FscreenSaverIdPlayerDesign;
  end;

  ArrayOfPlayers = array of Players;            { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Surveys = class(TRemotable)
  private
    FidSurvey: WideString;
    Fname: WideString;
    FstartDate: TXSDateTime;
    FendDate: TXSDateTime;
    FquestionsToAsk: Integer;
    FquestionsToWin: Integer;
    FquestionsTime: Integer;
    FisEnabled: Boolean;
    FisAnonymous: Boolean;
  public
    destructor Destroy; override;
  published
    property idSurvey: WideString read FidSurvey write FidSurvey;
    property name: WideString read Fname write Fname;
    property startDate: TXSDateTime read FstartDate write FstartDate;
    property endDate: TXSDateTime read FendDate write FendDate;
    property questionsToAsk: Integer read FquestionsToAsk write FquestionsToAsk;
    property questionsToWin: Integer read FquestionsToWin write FquestionsToWin;
    property questionsTime: Integer read FquestionsTime write FquestionsTime;
    property isEnabled: Boolean read FisEnabled write FisEnabled;
    property isAnonymous: Boolean read FisAnonymous write FisAnonymous;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  SurveysQuestions = class(TRemotable)
  private
    FidSurveyQuestion: WideString;
    FidSurvey: WideString;
    Fquestion: WideString;
    Fanswer1: WideString;
    Fanswer2: WideString;
    Fanswer3: WideString;
    Fcorrect: Integer;
    FisEnabled: Boolean;
  published
    property idSurveyQuestion: WideString read FidSurveyQuestion write FidSurveyQuestion;
    property idSurvey: WideString read FidSurvey write FidSurvey;
    property question: WideString read Fquestion write Fquestion;
    property answer1: WideString read Fanswer1 write Fanswer1;
    property answer2: WideString read Fanswer2 write Fanswer2;
    property answer3: WideString read Fanswer3 write Fanswer3;
    property correct: Integer read Fcorrect write Fcorrect;
    property isEnabled: Boolean read FisEnabled write FisEnabled;
  end;

  ArrayOfSurveysQuestions = array of SurveysQuestions;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  SurveysAnswers = class(TRemotable)
  private
    FidSurverAnswer: WideString;
    FidSurveyQuestion: WideString;
    FidPlayer: WideString;
    FansweredDate: TXSDateTime;
    FansweredTime: TXSDateTime;
    Fanswered: Integer;
    FansweredCorrect: Boolean;
    FuserName: WideString;
    FidUser: WideString;
  public
    destructor Destroy; override;
  published
    property idSurverAnswer: WideString read FidSurverAnswer write FidSurverAnswer;
    property idSurveyQuestion: WideString read FidSurveyQuestion write FidSurveyQuestion;
    property idPlayer: WideString read FidPlayer write FidPlayer;
    property answeredDate: TXSDateTime read FansweredDate write FansweredDate;
    property answeredTime: TXSDateTime read FansweredTime write FansweredTime;
    property answered: Integer read Fanswered write Fanswered;
    property answeredCorrect: Boolean read FansweredCorrect write FansweredCorrect;
    property userName: WideString read FuserName write FuserName;
    property idUser: WideString read FidUser write FidUser;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsCategories = class(TRemotable)
  private
    FidProductCategory: WideString;
    FidParent: WideString;
    Ftitle: WideString;
    Fdescription: WideString;
    FisActive: Boolean;
    FcategoryType: CATEGORY_TYPES;
  published
    property idProductCategory: WideString read FidProductCategory write FidProductCategory;
    property idParent: WideString read FidParent write FidParent;
    property title: WideString read Ftitle write Ftitle;
    property description: WideString read Fdescription write Fdescription;
    property isActive: Boolean read FisActive write FisActive;
    property categoryType: CATEGORY_TYPES read FcategoryType write FcategoryType;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  LanguagesResources = class(TRemotable)
  private
    FidLanguage: WideString;
    FidResource: WideString;
    Flabel_: WideString;
    FlabelExtra: WideString;
    Fhelp: WideString;
    FhelpExtra: WideString;
  published
    property idLanguage: WideString read FidLanguage write FidLanguage;
    property idResource: WideString read FidResource write FidResource;
    property label_: WideString read Flabel_ write Flabel_;
    property labelExtra: WideString read FlabelExtra write FlabelExtra;
    property help: WideString read Fhelp write Fhelp;
    property helpExtra: WideString read FhelpExtra write FhelpExtra;
  end;

  ArrayOfLanguagesResources = array of LanguagesResources;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Products2 = class(TRemotable)
  private
    FidProduct: WideString;
    FidProductCategory: WideString;
    FidProductBrand: WideString;
    Fbrand: WideString;
    FbrandType: WideString;
    FbrandStyle: WideString;
    FbrandStyleExtra: WideString;
    Frelated01: WideString;
    Frelated02: WideString;
    Frelated03: WideString;
    FbarCode01: WideString;
    FbarCode02: WideString;
    FbarCode03: WideString;
    Ftitle: WideString;
    Fdescription: WideString;
    Fprice: Double;
    Fwidth: Integer;
    Fheight: Integer;
    Fpoints: Integer;
    Fitems: Integer;
    Fstock: Integer;
    FidProductGroup: WideString;
    FdisplayOrder: Integer;
    FisActive: Boolean;
    Fcategory: ProductsCategories;
    FdisplayOrderCounter: Integer;
    FidProductPositionRelations: WideString;
    FlanguagesResources: ArrayOfLanguagesResources;
  public
    destructor Destroy; override;
  published
    property idProduct: WideString read FidProduct write FidProduct;
    property idProductCategory: WideString read FidProductCategory write FidProductCategory;
    property idProductBrand: WideString read FidProductBrand write FidProductBrand;
    property brand: WideString read Fbrand write Fbrand;
    property brandType: WideString read FbrandType write FbrandType;
    property brandStyle: WideString read FbrandStyle write FbrandStyle;
    property brandStyleExtra: WideString read FbrandStyleExtra write FbrandStyleExtra;
    property related01: WideString read Frelated01 write Frelated01;
    property related02: WideString read Frelated02 write Frelated02;
    property related03: WideString read Frelated03 write Frelated03;
    property barCode01: WideString read FbarCode01 write FbarCode01;
    property barCode02: WideString read FbarCode02 write FbarCode02;
    property barCode03: WideString read FbarCode03 write FbarCode03;
    property title: WideString read Ftitle write Ftitle;
    property description: WideString read Fdescription write Fdescription;
    property price: Double read Fprice write Fprice;
    property width: Integer read Fwidth write Fwidth;
    property height: Integer read Fheight write Fheight;
    property points: Integer read Fpoints write Fpoints;
    property items: Integer read Fitems write Fitems;
    property stock: Integer read Fstock write Fstock;
    property idProductGroup: WideString read FidProductGroup write FidProductGroup;
    property displayOrder: Integer read FdisplayOrder write FdisplayOrder;
    property isActive: Boolean read FisActive write FisActive;
    property category: ProductsCategories read Fcategory write Fcategory;
    property displayOrderCounter: Integer read FdisplayOrderCounter write FdisplayOrderCounter;
    property idProductPositionRelations: WideString read FidProductPositionRelations write FidProductPositionRelations;
    property languagesResources: ArrayOfLanguagesResources read FlanguagesResources write FlanguagesResources;
  end;

  ArrayOfProducts = array of Products2;         { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsPositionsRelations = class(TRemotable)
  private
    FidProductPositionRelations: WideString;
    FidProductPosition: WideString;
    FidProduct: WideString;
    Fcounter: Integer;
    Fposition: Integer;
  published
    property idProductPositionRelations: WideString read FidProductPositionRelations write FidProductPositionRelations;
    property idProductPosition: WideString read FidProductPosition write FidProductPosition;
    property idProduct: WideString read FidProduct write FidProduct;
    property counter: Integer read Fcounter write Fcounter;
    property position: Integer read Fposition write Fposition;
  end;

  ArrayOfProductsPositionsRelations = array of ProductsPositionsRelations;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProductsPositions = class(TRemotable)
  private
    FidProductPosition: WideString;
    Ftitle: WideString;
  published
    property idProductPosition: WideString read FidProductPosition write FidProductPosition;
    property title: WideString read Ftitle write Ftitle;
  end;

  ArrayOfProductsPositions = array of ProductsPositions;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  QueuesShifts = class(TRemotable)
  private
    FidQueueShift: WideString;
    FidQueue: WideString;
    FidParentQueue: WideString;
    Fletter: WideString;
    FidQueueCustomer: WideString;
    FidNumber: Integer;
    FidUser: WideString;
    FidPlayer: WideString;
    Freason: WideString;
    FqueueDate: TXSDateTime;
    FqueueTime: Double;
    FqueueStartTime: Double;
    FqueueEndTime: Double;
    FqueueCalls: Integer;
    FsentMail: Boolean;
  public
    destructor Destroy; override;
  published
    property idQueueShift: WideString read FidQueueShift write FidQueueShift;
    property idQueue: WideString read FidQueue write FidQueue;
    property idParentQueue: WideString read FidParentQueue write FidParentQueue;
    property letter: WideString read Fletter write Fletter;
    property idQueueCustomer: WideString read FidQueueCustomer write FidQueueCustomer;
    property idNumber: Integer read FidNumber write FidNumber;
    property idUser: WideString read FidUser write FidUser;
    property idPlayer: WideString read FidPlayer write FidPlayer;
    property reason: WideString read Freason write Freason;
    property queueDate: TXSDateTime read FqueueDate write FqueueDate;
    property queueTime: Double read FqueueTime write FqueueTime;
    property queueStartTime: Double read FqueueStartTime write FqueueStartTime;
    property queueEndTime: Double read FqueueEndTime write FqueueEndTime;
    property queueCalls: Integer read FqueueCalls write FqueueCalls;
    property sentMail: Boolean read FsentMail write FsentMail;
  end;

  ArrayOfQueuesShifts = array of QueuesShifts;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Queues = class(TRemotable)
  private
    FidQueue: WideString;
    FidQueueGroup: WideString;
    Fname: WideString;
    Fplace: WideString;
    Fcolor: WideString;
    Fletter: WideString;
    Fpriority: QUEUE_PRIORITY;
    FmaxPlaces: Integer;
    FsendMail: Boolean;
    FonlyValidatedUsers: Boolean;
  published
    property idQueue: WideString read FidQueue write FidQueue;
    property idQueueGroup: WideString read FidQueueGroup write FidQueueGroup;
    property name: WideString read Fname write Fname;
    property place: WideString read Fplace write Fplace;
    property color: WideString read Fcolor write Fcolor;
    property letter: WideString read Fletter write Fletter;
    property priority: QUEUE_PRIORITY read Fpriority write Fpriority;
    property maxPlaces: Integer read FmaxPlaces write FmaxPlaces;
    property sendMail: Boolean read FsendMail write FsendMail;
    property onlyValidatedUsers: Boolean read FonlyValidatedUsers write FonlyValidatedUsers;
  end;

  ArrayOfQueues = array of Queues;              { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Channels = class(TRemotable)
  private
    FidChannel: WideString;
    Fname: WideString;
    FchannelType: CHANNEL_TYPE;
    Furl: WideString;
  published
    property idChannel: WideString read FidChannel write FidChannel;
    property name: WideString read Fname write Fname;
    property channelType: CHANNEL_TYPE read FchannelType write FchannelType;
    property url: WideString read Furl write Furl;
  end;

  ArrayOfChannels = array of Channels;          { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ChannelsCameras = class(TRemotable)
  private
    FidChannel: WideString;
    FcameraType: CHANNEL_CAMERA_TYPE;
    Fconfiguration: WideString;
  published
    property idChannel: WideString read FidChannel write FidChannel;
    property cameraType: CHANNEL_CAMERA_TYPE read FcameraType write FcameraType;
    property configuration: WideString read Fconfiguration write Fconfiguration;
  end;

  ArrayOfChannelsCameras = array of ChannelsCameras;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  PlayersGroups = class(TRemotable)
  private
    FidPlayerGroup: WideString;
    FidParent: WideString;
    Fname: WideString;
  published
    property idPlayerGroup: WideString read FidPlayerGroup write FidPlayerGroup;
    property idParent: WideString read FidParent write FidParent;
    property name: WideString read Fname write Fname;
  end;

  ArrayOfPlayersGroups = array of PlayersGroups;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Users = class(TRemotable)
  private
    FidUser: WideString;
    FidCompany: WideString;
    FfirstName: WideString;
    FlastName: WideString;
    Femail: WideString;
    Fbirthday: WideString;
    FregistrationDate: WideString;
    Fphone: WideString;
    Fmobile: WideString;
    Fpassword: WideString;
    FpinCode: WideString;
    Fdni: WideString;
    FtotalLogin: Integer;
    FaccessLevel: ACCESS_LEVEL;
    FpinCodeExpirationDate: TXSDateTime;
    FlastBadLogin: TXSDateTime;
    FidProfessional: WideString;
    FidSocial: WideString;
    FsocialNumber: WideString;
    FsocialPlan: WideString;
    FsocialDate: TXSDateTime;
    Fcity: WideString;
    Faddress: WideString;
    FgeoLat: Double;
    FgeoLon: Double;
  public
    destructor Destroy; override;
  published
    property idUser: WideString read FidUser write FidUser;
    property idCompany: WideString read FidCompany write FidCompany;
    property firstName: WideString read FfirstName write FfirstName;
    property lastName: WideString read FlastName write FlastName;
    property email: WideString read Femail write Femail;
    property birthday: WideString read Fbirthday write Fbirthday;
    property registrationDate: WideString read FregistrationDate write FregistrationDate;
    property phone: WideString read Fphone write Fphone;
    property mobile: WideString read Fmobile write Fmobile;
    property password: WideString read Fpassword write Fpassword;
    property pinCode: WideString read FpinCode write FpinCode;
    property dni: WideString read Fdni write Fdni;
    property totalLogin: Integer read FtotalLogin write FtotalLogin;
    property accessLevel: ACCESS_LEVEL read FaccessLevel write FaccessLevel;
    property pinCodeExpirationDate: TXSDateTime read FpinCodeExpirationDate write FpinCodeExpirationDate;
    property lastBadLogin: TXSDateTime read FlastBadLogin write FlastBadLogin;
    property idProfessional: WideString read FidProfessional write FidProfessional;
    property idSocial: WideString read FidSocial write FidSocial;
    property socialNumber: WideString read FsocialNumber write FsocialNumber;
    property socialPlan: WideString read FsocialPlan write FsocialPlan;
    property socialDate: TXSDateTime read FsocialDate write FsocialDate;
    property city: WideString read Fcity write Fcity;
    property address: WideString read Faddress write Faddress;
    property geoLat: Double read FgeoLat write FgeoLat;
    property geoLon: Double read FgeoLon write FgeoLon;
  end;

  ArrayOfUsers = array of Users;                { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  QueuesGroups = class(TRemotable)
  private
    FidQueueGroup: WideString;
    FidParent: WideString;
    Fname: WideString;
  published
    property idQueueGroup: WideString read FidQueueGroup write FidQueueGroup;
    property idParent: WideString read FidParent write FidParent;
    property name: WideString read Fname write Fname;
  end;

  ArrayOfQueuesGroups = array of QueuesGroups;   { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  FileNode = class(TRemotable)
  private
    Fpath: WideString;
    FMD5: WideString;
  published
    property path: WideString read Fpath write Fpath;
    property MD5: WideString read FMD5 write FMD5;
  end;

  ArrayOfFileNode = array of FileNode;          { "http://tempuri.org/" }

  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : ManagerSoap
  // service   : Manager
  // port      : ManagerSoap
  // URL       : http://server-llamador/ws/manager.asmx
  // ************************************************************************ //
  ManagerSoap = interface(IInvokable)
  ['{DF6A2955-C36E-9037-F540-3184E3CCE219}']
    function  HelloWorld: WideString; stdcall;
    function  GetMaxRequestLength: Int64; stdcall;
    procedure AppendChunk(const FileName: WideString; const buffer: TByteDynArray; const Offset: Int64; const key: WideString); stdcall;
    function  DownloadChunk(const FileName: WideString; const Offset: Int64; const BufferSize: Integer; const key: WideString): TByteDynArray; stdcall;
    function  GetFileSize(const FileName: WideString): Int64; stdcall;
    function  GetFilesList: ArrayOfString; stdcall;
    function  CheckFileHash(const FileName: WideString): WideString; stdcall;
    function  GetUpdates: ArrayOfAnyType; stdcall;
    function  GetPlayersTimeLine: ArrayOfPlayersTimeLine; stdcall;
    function  GetPlayersTimeLineByIdPlayer(const idPlayer: WideString): ArrayOfPlayersTimeLine; stdcall;
    function  GetLicense: TecnoSignageLicense; stdcall;
    function  GetPlayersDesigns: ArrayOfPlayersDesigns; stdcall;
    function  SaveDesign(const item: PlayersDesigns; const email: WideString): WideString; stdcall;
    function  LoginUser(const email: WideString; const password: WideString): Boolean; stdcall;
    procedure SetLog(const log: WideString; const idPlayer: WideString; const key: WideString; const type_: PlayersLogType); stdcall;
    function  RegisterPlayer(const player: Players; const key: WideString): WideString; stdcall;
    function  PlayerStatus(const idPlayer: WideString; const diskSpace: Integer; const key: WideString): Players; stdcall;
    function  GetPlayers(const key: WideString): ArrayOfPlayers; stdcall;
    function  GetPlayer(const idPlayer: WideString; const key: WideString): Players; stdcall;
    function  GetCurrentSurvey: Surveys; stdcall;
    function  GetSurveyQuestions(const idSurvey: WideString): ArrayOfSurveysQuestions; stdcall;
    procedure UpdateAnswerData(const key: WideString; const surveyAnswer: SurveysAnswers); stdcall;
    procedure Import(const product: Products2; const id: WideString); stdcall;
    function  GetLanguagesResources: ArrayOfLanguagesResources; stdcall;
    procedure SetProduct(const product: Products2; const id: WideString); stdcall;
    function  GetProducts: ArrayOfProducts; stdcall;
    function  GetProductsPositionsRelations: ArrayOfProductsPositionsRelations; stdcall;
    function  GetProductsPositions: ArrayOfProductsPositions; stdcall;
    function  GetQueuesPending: ArrayOfQueuesShifts; stdcall;
    function  GetQueuesShiftsByIdPlayer(const idPlayer: WideString): ArrayOfQueuesShifts; stdcall;
    function  GetQueuesByIdPlayer(const idPlayer: WideString): ArrayOfQueues; stdcall;
    function  GetChannels: ArrayOfChannels; stdcall;
    function  GetChannelsCameras: ArrayOfChannelsCameras; stdcall;
    function  GetQueues: ArrayOfQueues; stdcall;
    function  GetPlayersGroups: ArrayOfPlayersGroups; stdcall;
    function  GetUsers(const key: WideString): ArrayOfUsers; stdcall;
    function  GetUserByDNI(const key: WideString; const dni: WideString): Users; stdcall;
    function  GetUserByFirstName(const key: WideString; const name: WideString): Users; stdcall;
    function  GetUserByLastName(const key: WideString; const name: WideString): Users; stdcall;
    function  GetQueuesGroups: ArrayOfQueuesGroups; stdcall;
    function  IsQueueGroupHidden: Boolean; stdcall;
    function  UpdateQueueShift(const queueShift: QueuesShifts): QueuesShifts; stdcall;
    function  GetAllMedia(const key: WideString): ArrayOfFileNode; stdcall;
    function  GetAllGames(const key: WideString): ArrayOfFileNode; stdcall;
    function  GetAllFolderGames(const key: WideString): ArrayOfFileNode; stdcall;
    function  CheckSyncFileHash(const FileName: WideString): WideString; stdcall;
  end;

function GetManagerSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ManagerSoap;


implementation

function GetManagerSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ManagerSoap;
const
  defWSDL = 'http://server-llamador/ws/manager.asmx?WSDL';
  defURL  = 'http://server-llamador/ws/manager.asmx';
  defSvc  = 'Manager';
  defPrt  = 'ManagerSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
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


constructor ArrayOfAnyType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function ArrayOfAnyType.GetVariantArray(Index: Integer): Variant;
begin
  Result := FanyType[Index];
end;

function ArrayOfAnyType.GetVariantArrayLength: Integer;
begin
  if Assigned(FanyType) then
    Result := Length(FanyType)
  else
  Result := 0;
end;

destructor PlayersTimeLine.Destroy;
begin
  if Assigned(FdateReleased) then
    FdateReleased.Free;
  if Assigned(FscheduleStartDate) then
    FscheduleStartDate.Free;
  if Assigned(FscheduleEndDate) then
    FscheduleEndDate.Free;
  inherited Destroy;
end;

destructor LicenseEntity.Destroy;
begin
  if Assigned(FCreateDateTime) then
    FCreateDateTime.Free;
  inherited Destroy;
end;

destructor Players.Destroy;
begin
  if Assigned(FlastReport) then
    FlastReport.Free;
  inherited Destroy;
end;

destructor Surveys.Destroy;
begin
  if Assigned(FstartDate) then
    FstartDate.Free;
  if Assigned(FendDate) then
    FendDate.Free;
  inherited Destroy;
end;

destructor SurveysAnswers.Destroy;
begin
  if Assigned(FansweredDate) then
    FansweredDate.Free;
  if Assigned(FansweredTime) then
    FansweredTime.Free;
  inherited Destroy;
end;

destructor Products2.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FlanguagesResources)-1 do
    if Assigned(FlanguagesResources[I]) then
      FlanguagesResources[I].Free;
  SetLength(FlanguagesResources, 0);
  if Assigned(Fcategory) then
    Fcategory.Free;
  inherited Destroy;
end;

destructor QueuesShifts.Destroy;
begin
  if Assigned(FqueueDate) then
    FqueueDate.Free;
  inherited Destroy;
end;

destructor Users.Destroy;
begin
  if Assigned(FpinCodeExpirationDate) then
    FpinCodeExpirationDate.Free;
  if Assigned(FlastBadLogin) then
    FlastBadLogin.Free;
  if Assigned(FsocialDate) then
    FsocialDate.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(ManagerSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ManagerSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterExternalParamName(TypeInfo(ManagerSoap), 'SetLog', 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ACCESS_LEVEL), 'http://tempuri.org/', 'ACCESS_LEVEL');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CHANNEL_CAMERA_TYPE), 'http://tempuri.org/', 'CHANNEL_CAMERA_TYPE');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CHANNEL_TYPE), 'http://tempuri.org/', 'CHANNEL_TYPE');
  RemClassRegistry.RegisterXSInfo(TypeInfo(QUEUE_PRIORITY), 'http://tempuri.org/', 'QUEUE_PRIORITY');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CATEGORY_TYPES), 'http://tempuri.org/', 'CATEGORY_TYPES');
  RemClassRegistry.RegisterXSInfo(TypeInfo(EQUIPMENT_TYPE), 'http://tempuri.org/', 'EQUIPMENT_TYPE');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SCREEN_SAVER_TYPE), 'http://tempuri.org/', 'SCREEN_SAVER_TYPE');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SCREEN_SAVER_TYPE), 'NONE2', 'NONE');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LicenseTypes), 'http://tempuri.org/', 'LicenseTypes');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LicenseTypesTecnoSignage), 'http://tempuri.org/', 'LicenseTypesTecnoSignage');
  RemClassRegistry.RegisterXSInfo(TypeInfo(PlayersLogType), 'http://tempuri.org/', 'PlayersLogType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://tempuri.org/', 'ArrayOfString');
  RemClassRegistry.RegisterXSInfo(TypeInfo(anyType), 'http://tempuri.org/', 'anyType');
  RemClassRegistry.RegisterXSClass(ArrayOfAnyType, 'http://tempuri.org/', 'ArrayOfAnyType');
  RemClassRegistry.RegisterSerializeOptions(ArrayOfAnyType, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(PlayersTimeLine, 'http://tempuri.org/', 'PlayersTimeLine');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersTimeLine), 'http://tempuri.org/', 'ArrayOfPlayersTimeLine');
  RemClassRegistry.RegisterXSClass(LicenseEntity, 'http://tempuri.org/', 'LicenseEntity');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LicenseEntity), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(TecnoSignageLicense, 'http://tempuri.org/', 'TecnoSignageLicense');
  RemClassRegistry.RegisterXSClass(PlayersDesigns, 'http://tempuri.org/', 'PlayersDesigns');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersDesigns), 'http://tempuri.org/', 'ArrayOfPlayersDesigns');
  RemClassRegistry.RegisterXSClass(Players, 'http://tempuri.org/', 'Players');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayers), 'http://tempuri.org/', 'ArrayOfPlayers');
  RemClassRegistry.RegisterXSClass(Surveys, 'http://tempuri.org/', 'Surveys');
  RemClassRegistry.RegisterXSClass(SurveysQuestions, 'http://tempuri.org/', 'SurveysQuestions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfSurveysQuestions), 'http://tempuri.org/', 'ArrayOfSurveysQuestions');
  RemClassRegistry.RegisterXSClass(SurveysAnswers, 'http://tempuri.org/', 'SurveysAnswers');
  RemClassRegistry.RegisterXSClass(ProductsCategories, 'http://tempuri.org/', 'ProductsCategories');
  RemClassRegistry.RegisterXSClass(LanguagesResources, 'http://tempuri.org/', 'LanguagesResources');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LanguagesResources), 'label_', 'label');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLanguagesResources), 'http://tempuri.org/', 'ArrayOfLanguagesResources');
  RemClassRegistry.RegisterXSClass(Products2, 'http://tempuri.org/', 'Products2', 'Products');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProducts), 'http://tempuri.org/', 'ArrayOfProducts');
  RemClassRegistry.RegisterXSClass(ProductsPositionsRelations, 'http://tempuri.org/', 'ProductsPositionsRelations');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProductsPositionsRelations), 'http://tempuri.org/', 'ArrayOfProductsPositionsRelations');
  RemClassRegistry.RegisterXSClass(ProductsPositions, 'http://tempuri.org/', 'ProductsPositions');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfProductsPositions), 'http://tempuri.org/', 'ArrayOfProductsPositions');
  RemClassRegistry.RegisterXSClass(QueuesShifts, 'http://tempuri.org/', 'QueuesShifts');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueuesShifts), 'http://tempuri.org/', 'ArrayOfQueuesShifts');
  RemClassRegistry.RegisterXSClass(Queues, 'http://tempuri.org/', 'Queues');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueues), 'http://tempuri.org/', 'ArrayOfQueues');
  RemClassRegistry.RegisterXSClass(Channels, 'http://tempuri.org/', 'Channels');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfChannels), 'http://tempuri.org/', 'ArrayOfChannels');
  RemClassRegistry.RegisterXSClass(ChannelsCameras, 'http://tempuri.org/', 'ChannelsCameras');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfChannelsCameras), 'http://tempuri.org/', 'ArrayOfChannelsCameras');
  RemClassRegistry.RegisterXSClass(PlayersGroups, 'http://tempuri.org/', 'PlayersGroups');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPlayersGroups), 'http://tempuri.org/', 'ArrayOfPlayersGroups');
  RemClassRegistry.RegisterXSClass(Users, 'http://tempuri.org/', 'Users');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfUsers), 'http://tempuri.org/', 'ArrayOfUsers');
  RemClassRegistry.RegisterXSClass(QueuesGroups, 'http://tempuri.org/', 'QueuesGroups');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfQueuesGroups), 'http://tempuri.org/', 'ArrayOfQueuesGroups');
  RemClassRegistry.RegisterXSClass(FileNode, 'http://tempuri.org/', 'FileNode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfFileNode), 'http://tempuri.org/', 'ArrayOfFileNode');

end. 