html, body { height: 100%; width: 100%; margin: 0; }

/* Fonts */
body { font-size: 11px; }
button { font-size: 100%; }
body, svg text { font-family: Tahoma, Verdana; }
button, select {font-family:inherit;}

@media print {
	body { font-size: 8pt; }
	body > .Toolbar {display:none;}
}

.Dashboard { position: relative; margin: auto; overflow: hidden; }

body.Scale {overflow:hidden;}
body > .ScaleWrapper {margin:auto;height:100%;}
body > .ScaleWrapper > .Dashboard {-moz-transform-origin:0 0;-webkit-transform-origin:0 0;-ms-transform-origin:0 0;}
body > .ScaleWrapper[l] > .Dashboard {margin:0;}
body > .ScaleWrapper[l2] > .Dashboard {margin:auto;-moz-transform-origin:50% 0;-webkit-transform-origin:50% 0;-ms-transform-origin:50% 0;}

.Dashboard > div { position: absolute; box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;}

/* Svg */
/* Don't anti-alias these since it makes them look better */
svg rect, svg line { shape-rendering: crispEdges; }

.LayoutWrapper > * { position:absolute;}

body > .Toolbar { position:absolute;top:0;right:0;min-height:1em;padding:0.2em 0.5em;border-left:solid 1px gray;border-bottom:solid 1px gray;border-radius:0 0 0 3px;background:#E4E4E4;background: -moz-linear-gradient(center top, white, #E4E4E4); background: -webkit-gradient(linear, center top, center bottom, from(white), to(#E4E4E4)); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='white', endColorstr='#E4E4E4');}
body > .Toolbar > .ToolbarToggle {position:absolute;right:0;top:0;opacity:0;margin:0;cursor:pointer;z-index:1;}
body > .Toolbar > .ToolbarIcon {position:absolute;right:0;top:0;font-size:larger;}
body > .Toolbar > .ToolbarIcon:after {content: "●";}
body > .Toolbar > .ToolbarCommands {margin-right:1em;display:none;}
body > .Toolbar > .ToolbarCommands > a {color:Black;display:inline-block;min-height:20px;padding-left:22px;background-size:contain;background-repeat:no-repeat;}
body > .Toolbar > .ToolbarCommands > .Logout {background-image:url('Resource.ashx?t=i&id=Logout.png');}
body > .Toolbar > .ToolbarCommands > .Export {background-image:url('Resource.ashx?t=i&id=EnhancedViewer.ExportDashboardData.png');}
body > .Toolbar > .ToolbarToggle:checked ~ .ToolbarCommands {display:block;}
body > .Toolbar > .ToolbarToggle:checked + .ToolbarIcon:after {content: "◌";}

body > .Templates { display:none;}

/* Error display */
.ScriptErrorDialog {background: rgba(0,0,0,0.3);}
.ScriptErrorDialog > div {display:table;width:100%;height:100%;}
.ScriptErrorDialog .ErrorPanel .Commands { display:block;}

/* Error status */
.ScriptErrorStatus .ErrorStatus {position:absolute;left: 5px;top: 5px;border:solid 1px gray;border-radius:3px;background:rgba(0,0,0,0.2);}
.ScriptErrorStatus #DetailsCommand {display:block;float:left;color:red;margin:2px;}
.ScriptErrorStatus #OkCommand {display:block;float:right;height:18px;width:18px;background-image:url('Resource.ashx?t=i&id=ErrorStatusClose.png');background-size:contain;background-repeat:no-repeat;}

/* Progress */
.Loading { background: url('Resource.ashx?t=i&id=ProgressIndicator.gif') no-repeat center center white;text-align:center;}
.LoadingOverlay, .ScriptErrorDialog { position:fixed;width:100%;height:100%;left:0;top:0;display:none;}
.LoadingOverlay > .Spinner { position:absolute;width:30px;height:30px;margin-left:-15px;margin-top:-15px;background: url('Resource.ashx?t=i&id=ProgressIndicator.gif') no-repeat center center white;border-radius:16px;border:solid 1px rgba(65, 140, 240, 0.4);}

.Watermark {position: absolute;top: 50%;width: 100%;text-align: center;opacity: 0.4;white-space: pre-wrap;pointer-events:none;}
.Watermark > label {text-shadow:2px 2px 3px black;}

/* Defaults */
.DashboardTextBox > textarea, .DashboardTextBox > input {background:transparent;}

/* Standard Controls */

.DashboardImage { overflow: hidden; }
.DashboardImage > img { position: absolute; }

.DashboardLabel { overflow: hidden; }
.DashboardLabel > div { display: table; height:100%; margin:auto;}
.DashboardLabel > div > div { display: table-cell;}
.DashboardLabel > div > div > label {display:inline-block;white-space:pre;cursor:inherit;line-height:1.2em; }

.DashboardFrame {overflow:hidden;}
.DashboardFrame .FrameTitle {overflow:hidden;cursor:inherit;position:absolute;width:100%;}
.DashboardFrame .FrameTitle > div { display: table; width: 100%; height:100%; }
.DashboardFrame .FrameTitle > div > div { display: table-cell; vertical-align: middle;}
.DashboardFrame .FrameTitle label { white-space:pre;cursor:inherit;display:inline-block;}
.DashboardFrame.DockLeft .FrameTitle {left:0;top:0;height:100%;}
.DashboardFrame.DockLeft .FrameTitle label {-moz-transform:rotate(-90deg);-webkit-transform:rotate(-90deg);-ms-transform:rotate(-90deg);}
.DashboardFrame.DockRight .FrameTitle {right:0;top:0;height:100%;}
.DashboardFrame.DockRight .FrameTitle label {-moz-transform:rotate(90deg);-webkit-transform:rotate(90deg);-ms-transform:rotate(90deg);}
.DashboardFrame.DockBottom .FrameTitle {left:0;bottom:0;width:100%;}

.DashboardHyperlink { display: table; }
.DashboardHyperlink a { display: table-cell; }
.DashboardHyperlink a:focus {border:solid 1px #73A9D8;}

.DashboardDropDownList select { height: 100%; width: 100%; }

.DashboardDashblockViewer { }
.DashboardDashblockViewer iframe { width: 100%; height: 100%; border: none; }
.DashboardDashblockViewer iframe.Error { background:white;}

.DashboardButton > button {border-radius:2px;padding:3px;border:none;}

.DashboardButton > button, .DashboardTextBox > input { width: 100%; height: 100%; }

.DashboardTextBox > input {}
.DashboardTextBox > textarea {resize:none;overflow:hidden;width:100%;height:100%;}
.DashboardTextBox > input, .DashboardTextBox > textarea {font:inherit;border:none;}

.DashboardSlider.Horizontal > .Track {position:absolute;top:50%;left:5px;right:5px;height:2px;border-radius:2px;border:solid 1px gray;margin-top:-1px;}
.DashboardSlider.Horizontal > button {position:absolute;top:50%;height:27px;width:17px;margin-top:-13.5px;margin-left:-8.5px;}

.DashboardSlider.Vertical > .Track {position:absolute;left:50%;top:5px;bottom:5px;width:2px;border-radius:2px;border:solid 1px gray;margin-left:-1px;}
.DashboardSlider.Vertical > button {position:absolute;left:50%;width:27px;height:17px;margin-left:-13.5px;}

.DashboardSlider > input {width:100%;height:100%;-webkit-tap-highlight-color:rgba(0,0,0,0);}
.DashboardSlider.Horizontal > input {-webkit-appearance:slider-horizontal;}
.DashboardSlider.Vertical > input {-webkit-appearance:slider-vertical;}

.DashboardUnknownControl { border:solid 1px lightgrey;border-radius:3px;overflow:hidden;}
.DashboardUnknownControl > .DashboardLabel {height:100%;}
.DashboardUnknownControl label {color:darkgray;}

.DashboardFilterUpdateButton > .DashboardButton {height:100%;}

/* Legend */
.DashboardLegend {padding:5px;}
.DashboardLegend.Vertical { display: -moz-box-flex; -moz-box-orientation: vertical; display: -webkit-box-flex; -webkit-box-orientation: vertical; }
.DashboardLegend .LegendTitle { text-align: center; font-weight: bold; width: 100%; }
.DashboardLegend.Vertical .LegendBody { -moz-box-flex: 1; -webkit-box-flex: 1; width: 100%; height: 100%; overflow: auto; }

.DashboardLegend .LegendItem { display: table; margin: 1px 5px; cursor:default;}
.DashboardLegend .LegendItem > * { display: table-cell; vertical-align: middle; }
.DashboardLegend .LegendItem label { cursor:inherit;}
.DashboardLegend .LegendItem .LegendMarker { margin-right: 4px; }
.DashboardLegend .LegendItem .LegendMarker > svg {display:block;}

.DashboardLegend.Horizontal .LegendBody { height: 100%; overflow:auto; }
.DashboardLegend.Horizontal .LegendBodyInner { height: 100%; width: 100%; }
.DashboardLegend.Horizontal .LegendItem { float:left; }

.DashboardLegend.Horizontal .LegendCategory {float:left;}
.DashboardLegend .LegendCategory .Title {font-weight:bold;}

.DashboardMap > .ZoomPanel {position:absolute;}
.DashboardMap > .ZoomPanel > button {width:25px;}

/* Parameter Controls */
.DateTimePicker > div {display:-moz-box;display:-webkit-box;height:100%;}
.DateTimePicker .Textbox  { -moz-box-flex:1;-webkit-box-flex:1;display:block;width:calc(100% - 28px);}
.DateTimePicker .Picker { cursor:pointer;}
.DateTimePicker.Disabled { opacity:0.6; }
.DateTimePicker.Disabled .Picker { cursor:default; }
	/* IE */
.DateTimePicker .Textbox  { width:calc(100% - 28px);}
.DateTimePicker .Picker { position:relative;top:calc(-100%);left:calc(100% - 24px);}

.DateTimeRangePicker.Horizontal > div {position:absolute;left:0;top:50%;margin-top:-12px;width:49%;height:24px;}
.DateTimeRangePicker.Horizontal > div:first-child {margin-right:2%;}
.DateTimeRangePicker.Horizontal > div:nth-child(2) {left:50%;}
.DateTimeRangePicker.Vertical > div {height:49%;}
.DateTimeRangePicker.Vertical > div:first-child {margin-bottom:2%;}
.DateTimeRangePicker .DateTimePicker {position:relative;width:100%;height:100%;display:-moz-box;display:-webkit-box;}

.ParameterDropDownList select, .ParameterAxisLevelDropDownList select { height: 100%; width: 100%; }
.ParameterDropDownList option.NamedToken { border-top:solid 1px darkgray;}
.ParameterDropDownList option.NamedToken ~ option {border:none;}
.ParameterDropDownList input[type=text] { position: absolute; height: 100%; width: 100%; }

.ParameterDropDownListAutoCompleteDropDown { max-height: 250px; overflow: auto; }
.ParameterDropDownListAutoCompleteDropDown > label { display: none; font-size: 120%; padding-top: 2px; padding-bottom: 2px; }
.ParameterDropDownListItemVisible { display: block !important; background: white; }
.ParameterDropDownListItemVisibleHover { background-color: #3399FF }

/* Any padding change here must also be reflected in the ParameterDropDownList.js positioning */
.ParameterDropDownListAutoCompleteDropArrow { position: absolute; cursor: default; font-size: 120%; padding: 4px; }
.ParameterDropDownListAutoCompleteDropArrow:after { content: '▼'; }

.ParameterTextBox > .DashboardTextBox {height:100%;}

.ParameterHierarchyViewer > button {width:100%;height:100%;}
.ParameterHierarchyRangeViewer .ParameterHierarchyViewer {width:50%;float:left;}
.ParameterCascadingHierarchyControl > div {overflow:auto;max-width:100%;max-height:100%;}
.ParameterCascadingHierarchyControl table {border-spacing:0;width:100%;}
.ParameterCascadingHierarchyControl td {padding:0;white-space:nowrap;}

.HierarchyPicker {width:300px;height:250px;font-size:120%;background:white;overflow:auto;border:solid 1px gray;-moz-user-select:none;-webkit-user-select:none;user-select:none;}
.HierarchyPicker ul {margin:0;padding:0;list-style-type:none;}
.HierarchyPicker > ul {margin:5px;}
.HierarchyPicker li > ul {margin-left:5px;display:none;}
.HierarchyPicker ul > li {margin-left:5px;margin-top:2px;margin-bottom:2px;}
.HierarchyPicker ul > li > span { background: url('Resource.ashx?t=i&id=Expand.svg') no-repeat;display:inline-block;width:11px;height:11px;margin-right:3px;backround-size:6px 10px;}
body[inputMode=touch] .HierarchyPicker ul > li > span {width:15px;height:15px;}
.HierarchyPicker ul > li[l] { margin-left:15px;}
.HierarchyPicker ul > li[l] > span { display:none;}
.HierarchyPicker ul > li.Expanded > span {background:url('Resource.ashx?t=i&id=Collapse.svg') no-repeat center;}
.HierarchyPicker li > ul > li {margin-left:5px;}
.HierarchyPicker li.Expanded > ul {display:block;}
.HierarchyPicker li > label:hover {text-decoration:underline;background:lightgrey;}
.HierarchyPicker li.Selected > label {background:lightblue;font-weight:bold;}
.HierarchyPicker li.Disabled > label {color:gray;text-decoration:none;background:transparent}
.HierarchyPicker .CloseCommand {position:absolute;bottom:0.5em;right:0.5em;}
.HierarchyPicker ul > li.NodeLoading > :not(span) { display:none;}
.HierarchyPicker ul > li.NodeLoading > span { background: url("Resource.ashx?t=i&id=TreeNodeProgressIndicator.gif") no-repeat left center;background-size:100%;height:100%;}
.HierarchyPicker ul > li.NodeLoading > span:after { content:'Loading';font-style:italic;padding-left:15px;}

.ParameterCheckBoxList {overflow:auto;}
.ParameterCheckBoxList > div.Horizontal > label {float:left;}
.ParameterCheckBoxList > div > label, .DashboardCheckBox > label {display:block;}
.ParameterCheckBoxList label > label, .ParameterCheckBoxList label > input, .DashboardCheckBox > label > label, .DashboardCheckBox > label > input {vertical-align:middle;}

.ParameterNumericUpDown > div {border:solid 1px gray;border-radius:4px;height:100%;display:-moz-box;display:-webkit-box;overflow:hidden;}
.ParameterNumericUpDown > div > * {display:block;height:100%;}
.ParameterNumericUpDown > div > input {text-align:right;border:none;height:90%;margin:1px;-moz-box-flex:1;-webkit-box-flex:1;width:calc(100% - 20px);}
.ParameterNumericUpDown .UpDownContainer {position:relative;left:calc(100% - 18px);top:calc(-100% - 2px);width:18px;border-radius:0 4px 4px 0;border-left:1px solid gray;background:#E4E4E4; background: -moz-linear-gradient(center top, white, #E4E4E4); background: -webkit-gradient(linear, center top, center bottom, from(white), to(#E4E4E4)); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='white', endColorstr='#E4E4E4');}
.ParameterNumericUpDown .UpDownContainer > button {display:block;width:100%;height:50%;background:none;border:none;margin:0;padding:0;text-align:center;font-size:70%;}
body[inputMode=mouse] > div > .Dashboard > .ParameterNumericUpDown .UpDownContainer > button:hover,
body[inputMode=mouse] > div > .Dashboard > .ParameterRangeNumericUpDown .UpDownContainer > button:hover {background:#5288CC;}
.ParameterNumericUpDown .UpDownContainer > button[disabled] {opacity:0.4;}
.ParameterNumericUpDown .UpDownContainer > button[disabled]:hover {background:none;}
.ParameterNumericUpDown > input[type="number"] {width:100%;height:100%;padding:0;border:none;}

.ParameterRangeNumericUpDown > div {height:90%;}
.ParameterRangeNumericUpDown .ParameterNumericUpDown {float:left;width:50%;height:100%;}
.ParameterRangeNumericUpDown .ParameterNumericUpDown:first-child {width:49%;margin-right:2px;}

input.NamedToken, option.NamedToken { font-style:italic;color:#707070;}

/* DVs */
.DashboardDataGrid { overflow: auto; }
.DashboardDataGrid > table, .DashboardDataGrid td > table { width: 100%; border-collapse: collapse; }

.DashboardDataGrid th.SortAsc:after { content: '▲'; }
.DashboardDataGrid th.SortDesc:after { content: '▼'; }

.DashboardDataGrid tbody td, .DashboardDataGrid thead th, .DashboardDataGrid tfoot td { border:none; border-right: solid 1px #C0C0C0; border-bottom: solid 1px #C0C0C0;padding-left:4px;padding-right:4px;}
.DashboardDataGrid thead th { font-weight:normal;text-align:left;white-space:pre;background:#f8f8f8; background:url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMTAwJSIgd2lkdGg9IjEwMCUiIHZlcnNpb249IjEuMCI+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJkZWZfQ2xjOEFRPT1fMSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPjxzdG9wIHN0eWxlPSJzdG9wLWNvbG9yOiNmZmZmZmYiIG9mZnNldD0iMCUiPjwvc3RvcD48c3RvcCBzdHlsZT0ic3RvcC1jb2xvcjojZGVkYmRlIiBvZmZzZXQ9IjEwMCUiPjwvc3RvcD48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48cmVjdCBzdHlsZT0iZmlsbDp1cmwoI2RlZl9DbGM4QVE9PV8xKSIgaGVpZ2h0PSIxMDAlIiB3aWR0aD0iMTAwJSI+PC9yZWN0Pjwvc3ZnPg==');background: -moz-linear-gradient(white, #dedbde); background:-webkit-gradient(linear, left top, left bottom, from(white), to(#dedbde));cursor:pointer; }
.DashboardDataGrid thead th[ns] {cursor:auto;}
.DashboardDataGrid tfoot td {text-align:right;}
.DashboardDataGrid tfoot td:first-child {text-align:left;}

/* Row hover over highlight */
body[inputMode=mouse] > div > .Dashboard > .DashboardDataGrid > table > tbody > tr:hover > td { background: #c9daef; }

.DashboardDataGrid tbody td > svg, .DashboardDataGrid tbody td > img { display:block; margin:auto; }
.DashboardDataGrid tr.RowGroup > td:first-child {height:20px;text-align:left !important;padding-left:1px;}
.DashboardDataGrid tr.RowGroup > td > .Toggle { width:11px;height:11px;display:inline-block;margin-right:0.25em;background:url('Resource.ashx?t=i&id=Collapse.svg') no-repeat;}
.DashboardDataGrid tr.RowGroup.Collapsed > td > .Toggle { background:url('Resource.ashx?t=i&id=Expand.svg') no-repeat;}

/* Indent rows below row groups */
.DashboardDataGrid tbody > tr[d="1"] td:first-child { padding-left:1em;}
.DashboardDataGrid tbody > tr[d="2"] td:first-child { padding-left:2em;}
.DashboardDataGrid tbody > tr[d="3"] td:first-child { padding-left:3.5em;}
.DashboardDataGrid tbody > tr[d="4"] td:first-child { padding-left:4.5em;}
.DashboardDataGrid tbody > tr[d="5"] td:first-child { padding-left:5.5em;}

.DashboardDataGrid > table[c] tr[d="1"],
.DashboardDataGrid > table[c] tr[d="2"],
.DashboardDataGrid > table[c] tr[d="3"],
.DashboardDataGrid > table[c] tr[d="4"],
.DashboardDataGrid > table[c] tr[d="5"] {display:none;}

.DashboardDataGrid > table > tbody > tr[d][c="0"] {display:table-row;}
.DashboardDataGrid > table > tbody > tr[c="1"] {display:none;}

.DashboardDataLabel > .DashboardLabel { width: 100%; height: 100%; }

/* Shapes */
.DashboardLine > div { position: absolute; }
.DashboardLine.Horizontal > div { width: 100%; top: 50%; }
.DashboardLine.Vertical > div { height: 100%; left: 50%; }

/* Popup */
.DashboardPopup { position: absolute;background:white;overflow:hidden; z-index: 10000; border: 1px solid gainsboro; -moz-box-shadow: 3px 3px 5px black; -webkit-box-shadow: 3px 3px 5px black; border-radius:3px;-moz-transform:scale(0);-webkit-transform:scale(0);-ms-transform:scale(0);}
.DashboardPopup.Open { -moz-transform:scale(1);-webkit-transform:scale(1);-ms-transform:scale(1); } 

/* Script services popup */
.DashboardPopup.ScriptServices { background:none;border:none;border-radius:0;-moz-box-shadow:none;-webkit-box-shadow:none;}
.DashboardPopup.ScriptServices > .Content > div > iframe { width: 100%; height: 100%; border: none; -moz-transform-origin:0 0;-webkit-transform-origin:0 0;-ms-transform-origin:0 0; }
.DashboardPopup.ScriptServices > .Content > .Loading > iframe { display:none; }
.DashboardPopup.ScriptServices > .Content > .Loading { min-width:200px;min-height:200px;}
.DashboardPopup.ScriptServices .NoDashboard, .DashboardPopup.ScriptServices > .Content > .Loading {border:solid 1px #444444;border-radius:3px;}
.DashboardPopup.ScriptServices .NoDashboard {background:white;}
.DashboardPopup.ScriptServices .NoDashboard > iframe { max-height:300px;}

/* Panel View */

.PanelView {position:absolute;width:100%;left:0;top:0;background:white;-webkit-transform:translateX(-100%);}
body.PanelViewOpened .PanelView { -webkit-transform:translateX(0); }
body.PanelViewClosing .PanelView { -webkit-transition: -webkit-transform 0.5s;-webkit-transform:translateX(100%); }

.PanelView > div {margin:auto;}
.PanelView > div.Loading iframe {border:none;display:block;width:100%;height:0;}
.PanelView > div.Loading {width:75%;height:200px;border:solid 1px gainsboro;border-radius:3px;}
.PanelView iframe {border:none;display:block;width:100%;}

body.PanelViewOpening > div > .Dashboard { -webkit-transition: -webkit-transform 0.7s;-webkit-transform:translateX(-110%); }
body.PanelViewOpened > div > .Dashboard { -webkit-transform:translateX(-110%); }
body.PanelViewClosing > div > .Dashboard { -webkit-transition: -webkit-transform 0.5s;-webkit-transform:translateX(0); }

/* DashboardAnimator */
.DashboardAnimator_Show { -moz-transition: opacity 0.7s;-webkit-transition: opacity 0.7s;opacity:1 !important;}
.DashboardAnimator_Hide { -moz-transition-property: opacity, -moz-transform;-moz-transition-duration:0.7s, 0.1s;-moz-transition-delay: 0s, 0.7s;-webkit-transition-property: opacity, -webkit-transform;-webkit-transition-duration:0.7s, 0.1s;-webkit-transition-delay: 0s, 0.7s;-moz-transform:scale(0);-webkit-transform:scale(0);-ms-transform:scale(0);opacity:0 !important;}

.DashboardAnimator_Show > svg > g {opacity:1 !important;}

/* Mobile Tooltip */
.DashboardPopup .Content > .TooltipPopupContent {background:white;border:solid 1px darkgray;border-radius:3px;padding:5px;font-size:150%;}
.DashboardPopup .Content > .TooltipPopupContent label {white-space:pre;}

/* Date Picker */
.DatePicker {background:white;min-width:154px;}
.DatePicker.Year_Grain .Months {display:none;}
.DatePicker.Year_Grain .Days {display:none;}
.DatePicker.Month_Grain .Days {display:none;}
.DatePicker .Years > div > div:nth-child(2) {text-align:center;}
.DatePicker .Years label {font-family:Courier New;}
.DatePicker .Months {display:table;width:100%;margin-top:0.25em;}
.DatePicker .Months > div {display:table-row;}
.DatePicker .Months > div > div {display:table-cell;}
.DatePicker .Months > div > div > label, .DatePicker .Days > .DayValues label {display:block;border: solid 1px #d3d3d3;border-radius:2px;background:#ededed;}
.DatePicker .Months > div > div > label, .DatePicker .Years label, .DatePicker .Days > .DayValues label {margin: 1px 2px;padding: 1px 2px;text-align:center;}
.DatePicker .Months > div > div > label:hover, .DatePicker .Years label:hover, .DatePicker .Days .DayValues label:hover {background:lightgray;text-decoration:underline;}
.DatePicker .Months .Selected > label, .DatePicker .DayValues .Selected > label {color:black;background:#a1d5fe;border:solid 1px darkGray;}
.DatePicker .Years > div {display:table;width:100%;}
.DatePicker .Years > div > * {display:table-cell;}
.DatePicker .Years input {width:3em;}
.DatePicker .Days {border-top: solid 1px d0d0d0;margin-top:0.25em;display:table;}
.DatePicker .Days .DayNames {display:table-header-group;}
.DatePicker .Days .DayNames > div {display:table-cell;border-bottom:dotted 1px #c0c0c0;}
.DatePicker .Days .DayNames > div > label {display:block;margin:1px 2px;text-align:center;}
.DatePicker .Days .DayValues {display:table-row-group;width:100%;border-collapse:collapse;}
.DatePicker .Days .DayValues > div {display:table-row;}
.DatePicker .Days .DayValues > div > div {display:table-cell;}
.DatePicker .Days .DayValues label:empty {display:none;}

/* Export */
.ExportDialog {height:300px;width:250px;background:#E4E4E4; background: -moz-linear-gradient(center top, white, #E4E4E4); background: -webkit-gradient(linear, center top, center bottom, from(white), to(#E4E4E4)); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='white', endColorstr='#E4E4E4');border:solid 1px gray;border-radius:2px;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-ms-box-sizing:border-box;height:100%;}
.ExportDialog .Title {font-size:larger;margin-bottom:10px;padding-left:5px;background:#C0DBFE; background:url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMTAwJSIgd2lkdGg9IjEwMCUiIHZlcnNpb249IjEuMCI+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJkZWZfeTJyTkFBPT1fMSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPjxzdG9wIHN0eWxlPSJzdG9wLWNvbG9yOiM2ZGEzZWEiIG9mZnNldD0iMCUiPjwvc3RvcD48c3RvcCBzdHlsZT0ic3RvcC1jb2xvcjojYTNjNmY2IiBvZmZzZXQ9IjE2LjQlIj48L3N0b3A+PHN0b3Agc3R5bGU9InN0b3AtY29sb3I6I2MwZGJmZSIgb2Zmc2V0PSIxMDAlIj48L3N0b3A+PC9saW5lYXJHcmFkaWVudD48L2RlZnM+PHJlY3Qgc3R5bGU9ImZpbGw6dXJsKCNkZWZfeTJyTkFBPT1fMSkiIGhlaWdodD0iMTAwJSIgd2lkdGg9IjEwMCUiPjwvcmVjdD48L3N2Zz4=');background: -moz-linear-gradient(center top, #6DA3EA, #A3C6F6 16.4%, #C0DBFE); background: -webkit-gradient(linear, center top, center bottom, from(#6DA3EA), to(#C0DBFE), color-stop(0.164, #A3C6F6));}
.ExportDialog .ExportControlsPanel {width:95%;border:solid 1px gray;border-radius:2px;margin-left:2%;margin-top:5px;}
.ExportDialog .ExportControlsPanel select {width:100%;border:none;}
.ExportDialog .ExportFormatPanel {margin-left:3px;}
.ExportDialog .ExportFormatPanel .ExportFormat {width:100%;}
.ExportDialog .Commands {margin-top:5px;text-align:right;padding-right:5px;padding-bottom:3px;}
.Dashboard > div.ExportHighlight {border:solid 2px red !important;border-radius:2px;}
.ExportDialog .ExportContent {display:table;width:100%;}
.ExportDialog .ExportContent > div {display:table-cell;}
.ExportDialog .ExportAdvancedOptions {display:none;}
.ExportDialog .ExportAdvancedOptions .OptionsPanel > label {display:block;margin-bottom:3px;}
.ExportDialog .ExportAdvancedOptions .OptionsPanel select,
.ExportDialog .ExportAdvancedOptions .OptionsPanel input[type="text"] {display:block;}
.ExportDialog .ExportAdvancedOptions .OptionsPanel select[name="OutputFormat"] {width:75%;}
.ExportDialog.Advanced {width:450px;}
.ExportDialog.Advanced .ExportContent > div {width:50%;}
.ExportDialog.Advanced .ExportCoreOptions {padding-right:1em;border-right:solid 1px gray;}
.ExportDialog.Advanced .ExportAdvancedOptions {display:block;padding-left:0.5em;}
.ExportContent.Formatted .UnformattedOnly {display:none !important;}

/* Small screen mobile device */
@media screen and (max-device-width: 500px) and (max-device-height: 500px)
{		
}
