include "Lib::common.xjs";

/*
  All code inspired by WMC0201200 and PMC0300501
*/

var fv_pageSize = 20;

function div_search_btn_search_onclick(obj: Button, e: ClickEventInfo) {
  trace("Ole");
  //fn_search();
  dummy();
}

function dummy() {
  ds_output_multi_temp.clearData();
  ds_output_multi_temp.addRow();

  ds_output_multi_temp.setColumn(0, "card_no		", "001");
  ds_output_multi_temp.setColumn(0, "auth_seq_no	", "001");
  ds_output_multi_temp.setColumn(0, "tid			", "001");
  ds_output_multi_temp.setColumn(0, "mid			", "001");
  ds_output_multi_temp.setColumn(0, "auth_date	", "001");
  ds_output_multi_temp.setColumn(0, "auth_time	", "001");

  gfn_pre_append(ds_output_multi_temp);	// Bikin dataset nya lebih siap untuk copas ke tempat lain
  ds_output_multi.appendData(ds_output_multi_temp, true);
}

function fn_search() {

  if (!validation_check()) { return; }

  ds_search_input.clearData();
  ds_search_input.addRow();
  /*ds_search.setColumn(0	,"inqr_strt_date"		, div_search.cal_rcpt_sdate.value );*/
  ds_search_input.setColumn(0, "mid		", div_search.edit_mid.value);
  ds_search_input.setColumn(0, "start_date", div_search.start_date.value);
  ds_search_input.setColumn(0, "end_date	", div_search.end_date.value);
  ds_search_input.setColumn(0, "page_size", fv_pageSize);

  if (!gfn_isNull(ds_output_multi.getColumn(0, "next_key"))) {
    ds_search_input.setColumn(0, "next_key", ds_output_multi.getColumn(0, "next_key"));
  }

  trace(ds_search_input.saveXML());
  var s = gfn_Transaction(this
    , "TESTRUCCI"
    , "ds_search_input=S"
    , "S=ds_output_single M=ds_output_multi_temp"
    , "fn_Callback");
}

function validation_check() {
  var startDate = div_search.start_date.value;
  var endDate = div_search.end_date.value;
  var mid = div_search.edit_mid.value;

  if (gfn_isNull(startDate)) {
    gfn_msg("Start date cannot be empty"); // Start Date
    div_search.start_date.setFocus();
    return false;
  }
  else if (gfn_isNull(endDate)) {
    gfn_msg("End date cannot be empty"); // End Date
    div_search.end_date.setFocus();
    return false;
  }
  else if (startDate > endDate) {
    gfn_msg("Start Date Cannot be Bigger than End Date");
    div_search.start_date.setFocus();
    return false;
  }
  else if (gfn_isNull(mid)) {
    gfn_msg("MID cannot be empty");
    div_search.edit_mid.setFocus();
    return false;
  }
  return true;
}

function fn_callback(sSvcID, nErrorCode, sErrorMsg) {
  trace("fn_Callback....sSvcID, nErrorCode, sErrorMsg.....!!! [" + sSvcID + "][" + nErrorCode + "][" + sErrorMsg + "]");

  if (nErrorCode == 1) {
    gfn_msg(sErrorMsg);
    return;
  }

  if (sSvcid == "TESTRUCCI") {
    trace(ds_output_single);
    trace(ds_output_multi);

    if (gfn_isNull(ds_output_single.getColumn(0, "next_key")) {
      btn_next.enable = false;
    }
    else {
      ds_search_input.setColumn(0, "next_key", ds_output_single.getColumn(0, "next_key"));
    }
  }

  gfn_pre_append(ds_output_multi_temp);	// Bikin dataset nya lebih siap untuk copas ke tempat lain
  ds_output_multi.appendData(ds_output_multi_temp, true);

  trace(ds_output_multi.saveXML());

  //untuk menampilkan jumlah baris data sesuai yang dimasukan pada edt_cur atau kolom paging dan menyesuaikan baris
  current_count.value = ds_output_multi.rowcount;
  ds_output_multi.rowposition = ds_output_multi.rowcount - 1;

}

function grd_list_onvscrolllastover(obj: Grid, e: ScrollEventInfo) {
  if (e.pos == grd_list.vscrollbar.max && btn_next.enable && ds_output_multi_temp.rowcount > 0) {
    fn_search();
  }
}


















