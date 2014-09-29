# macro defined
fs = require 'fs'
path = require 'path'

module.exports =
  OS_DARWIN:'darwin'
  OS_PATH:'PATH'
  COL_KEY:"collections"
  CHA_KEY:"channels"
  bash_path_key:'emp-debugger.path'
  COL_ROOT_TYPE:1
  COL_CH_TYPE:0
  ITEM_CHA_TYPE:1
  ITEM_COL_TYPE:0
  # channel 回调类型
  CHANNEL_ADAPTER:'channel_adapter'
  CHANNEL_NEW_CALLBACK: 'new_callback'
  CHANNEL_CALLBACK: 'channel_callback'
  CHANNEL_PROXY: 'channel_proxy'

  CHA_CODE_DIR:'test/src'
  CHA_PUBLIC_DIR:'test/public'

  # channel adapter 代码生成过程中的取值类型，
  # 分别为 params， arg， session
  ADAPTER_ARG_M_P:'param'
  ADAPTER_ARG_M_A:'arg'
  ADAPTER_ARG_M_S:'session'

  # 离线资源平台
  ADAPTER_PLT_D: 'common'
  ADAPTER_PLT_I: 'iphone'
  ADAPTER_PLT_A: 'android'
  ADAPTER_PLT_W: 'wphone'

  # 离线资源分辨率
  ADAPTER_PLT_R: 'default'
  ADAPTER_PLT_R1: '320-480'
  ADAPTER_PLT_R2: '640-960'
  ADAPTER_PLT_R3: '640-1136'


  GEN_VIEW:'gen_view'
  ADD_CHA_VIEW:'add_cha_view'
  ADD_COL_VIEW:'add_col_view'


  ATOM_CONF_CHANNEL_DIR_KEY:'emp-debugger.Channel-config-file'
  ATOM_CONF_CHANNEL_DIR_DEFAULT:'/config/channel.conf'

  # adapter template
  STATIC_COLLECTION_TEMPLATE:"/templates/"
  STATIC_CHANNEL_TEMPLATE:"/templates/channel/"
  CHANNEL_ADAPTER_DIR:'adapter'
  CHANNEL_NEW_CALLBACK_DIR: 'new_callback'
  CHANNEL_CALLBACK_DIR: 'callback'
  STATIC_ERL_TEMPLATE : "/channel_adapter_erl_template.tmp"
  STATIC_ERL_FUN_TEMPLATE : "/channel_adapter_erl_function.tmp"
  STATIC_CS_TEMPLATE : "/channel_adapter_cs_template.tmp"
  STATIC_OFF_TEMPLATE : "/channel_adapter_xHtml_template.tmp"

  COMMON_DIR_LIST :["images", "css", "lua", "xhtml","channels"]
  OFF_CHA_DIR_LIST : ["xhtml", "css", "lua", "images", "json"]
  OFF_CHA_PLT_LIST:["wp", "iphone", "android", "common"]
  OFF_BASE_DIR_LIST:["default"]
  OFF_DEFAULT_BASE:"channels"
  OFF_COMMON_BASE:"default"

  OFF_EXTENSION_ERL: "erl";
  OFF_EXTENSION_CS: "cs";
  OFF_EXTENSION_JSON: "json";
  OFF_EXTENSION_XHTML:"xhtml";

  DEFAULT_COL_ITEM:'[{item_id,"$cha_id"},{item_type,$itype},{menu_order,$order}]'

  DEFAULT_CHA_TMP:'\n{channels,[[{id,\"${channel}\"},\r\n'+
                  '            {app,\"${app}\"},\r\n'+
                  '            {name,"${name}"},\r\n'+
                  '            {entry,channel_adapter},\r\n'+
                  '            {views, ${views}},\r\n'+
                  '            {props,${props}},\r\n'+
                  '            {state,${state}}]'

  ADAPTER_REQUEST_PARAMS_FORMAT:"                                      {'$key', $value}";
  ADAPTER_VARIABLE : "    $var = $getter(\"$key\", []),\r\n";
  REPLACE_GETTER : "\\$getter";
  ADAPTER_REQUEST_PARAMS: "{'$key', $value}";


module.exports.show_error = (err_msg) ->
  atom.confirm
    message:"Error"
    detailedMessage:err_msg

module.exports.show_info = (info_msg) ->
  atom.confirm
    message:"Info"
    detailedMessage:info_msg

module.exports.isEmpty = (obj) ->
    for key,name of obj
        false;
    true;



module.exports.mkdir_sync = (tmp_dir) ->
  if !fs.existsSync(tmp_dir)
    fs.mkdirSync(tmp_dir);


module.exports.mkdirs_sync = (root_dir, dir_list) ->
  for dir in dir_list
    tmp_dir = root_dir+dir
    if !fs.existsSync(tmp_dir)
      fs.mkdirSync(tmp_dir);
