.ErrorDialog {margin:auto;width:50%;max-width:600px;margin-top:6em;}
.ErrorPanel { width:100%; display: -moz-box; display: -webkit-box; -moz-box-orient: vertical; -webkit-box-orient: vertical; box-shadow: 3px 3px rgba(0,0,0,.75); -webkit-box-shadow: 3px 3px rgba(0,0,0,.75); border-radius: 3px; border: solid 1px rgba(0,0,0,.38); background:#E4E4E4; background: -moz-linear-gradient(center top, white, #E4E4E4); background: -webkit-gradient(linear, center top, center bottom, from(white), to(#E4E4E4)); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='white', endColorstr='#E4E4E4');font-size: larger; text-align:left;}
.ErrorPanel .Title { background:#C0DBFE; background:url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMTAwJSIgd2lkdGg9IjEwMCUiIHZlcnNpb249IjEuMCI+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJkZWZfeTJyTkFBPT1fMSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPjxzdG9wIHN0eWxlPSJzdG9wLWNvbG9yOiM2ZGEzZWEiIG9mZnNldD0iMCUiPjwvc3RvcD48c3RvcCBzdHlsZT0ic3RvcC1jb2xvcjojYTNjNmY2IiBvZmZzZXQ9IjE2LjQlIj48L3N0b3A+PHN0b3Agc3R5bGU9InN0b3AtY29sb3I6I2MwZGJmZSIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+PC9saW5lYXJHcmFkaWVudD48L2RlZnM+PHJlY3Qgc3R5bGU9ImZpbGw6dXJsKCNkZWZfeTJyTkFBPT1fMSkiIGhlaWdodD0iMTAwJSIgd2lkdGg9IjEwMCUiPjwvcmVjdD48L3N2Zz4=');background: -moz-linear-gradient(center top, #6DA3EA, #A3C6F6 16.4%, #C0DBFE); background: -webkit-gradient(linear, center top, center bottom, from(#6DA3EA), to(#C0DBFE), color-stop(0.164, #A3C6F6)); border-bottom: solid 1px rgba(0,0,0,.51); }
.ErrorPanel .Title > label { margin-left: 3px; }
.ErrorPanel .Body { -moz-box-flex: 1; display: -moz-box; -moz-box-orient: horizontal; -webkit-box-flex: 1; display: -webkit-box; -webkit-box-orient: horizontal; }
.ErrorPanel .Body .ErrorContent { -moz-box-flex: 1; -moz-box-orient: vertical; -webkit-box-flex: 1; display: -webkit-box; -webkit-box-orient: vertical; }
.ErrorPanel .ErrorContent .Details {-moz-transition:height 0.4s;-webkit-transition:height 0.4s; height:0; overflow:hidden;margin: 3px 3px 3px 0; font-size: 0.8em; background: #fbfbfb; }
.ErrorPanel .ErrorContent .Details p { white-space: pre-wrap; margin: 0; max-height:30em; }
.ErrorPanel .ErrorContent .AdditionalInfoLabel { font-weight: bold; }
.ErrorPanel .ErrorContent .Message { margin: 8px 0;max-height:4em;overflow:hidden; }
.ErrorPanel .Body .Icon { margin: 8px; }
.ErrorPanel .Body .Icon > div { background:url('Error.png') no-repeat;width:77px;height:84px; }
.ErrorPanel .Commands { display:none;text-align:right;padding-right:1em;}
.ErrorPanel .Commands > button {width:73px;}

/* IE */
.ErrorPanel .Body .Icon { width:calc(77px); }
.ErrorPanel .ErrorContent { width:calc(100% - 77px - 10px);margin-left:calc(77px + 10px);margin-top:calc(-84px);}

.ErrorContent .DetailsContainer { position:relative}
.ErrorContent .DetailsContainer > div {position:absolute;left:0;top:0;}
.ErrorPanel .ErrorContent .Details { position:relative;}

.AdditionalInfoToggle {display:block;width:20px;height:20px;border:solid 1px darkgray;border-radius:20px;background:#E4E4E4; background: -moz-linear-gradient(center top, white, #E4E4E4); background: -webkit-gradient(linear, center top, center bottom, from(white), to(#E4E4E4));}
.AdditionalInfoToggle .Arrow { position: absolute; pointer-events:none;left: 35%; top: 10%; height: 80%; width: 80%; overflow:hidden;-moz-transform-origin:20% 50%;-webkit-transform-origin:20% 50%;-ms-transform-origin:20% 50%;-moz-transition: -moz-transform 0.3s;-webkit-transition: -webkit-transform 0.3s;-moz-transform: rotate(0); -ms-transform:rotate(0);-webkit-transform: rotate(0);}       
.AdditionalInfoToggle .Arrow > div { width: 100%; height: 100%; position: absolute; background:black;}
.AdditionalInfoToggle .Arrow > div:first-child { background: black;-moz-transform: translateX(-70%) rotate(45deg);-webkit-transform: translateX(-70%) rotate(45deg);-ms-transform: translateX(-70%) rotate(45deg);}

.ErrorPanel .ErrorContent #ToggleElement {opacity:0;position:relative;z-index:1;}
.ErrorPanel .ErrorContent #ToggleElement:checked + .AdditionalInfoToggle .Arrow { -moz-transition: -moz-transform 0.3s;-webkit-transition: -webkit-transform 0.3s; -moz-transform: rotate(90deg); -ms-transform:rotate(90deg);-webkit-transform: rotate(90deg); }
.ErrorPanel .ErrorContent #ToggleElement:checked ~ .Details {-moz-transition:height 0.3s;-webkit-transition:height 0.3s;height:300px;border: solid 1px gainsboro;overflow:auto;}

