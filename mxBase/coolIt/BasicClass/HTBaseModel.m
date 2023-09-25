//
//  HTBaseModel.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "HTBaseModel.h"

@implementation HTBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSMutableDictionary *var_mapping = [[NSMutableDictionary alloc] init];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"id"] forKey:@"var_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"description"] forKey:@"var_desc"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"hd"] forKey:@"var_hd"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"sd"] forKey:@"var_sd"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"new_flag"] forKey:@"var_new_flag"];
    
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"] forKey:@"var_title"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"] forKey:@"var_tag"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"] forKey:@"var_detail"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"titleColor"] forKey:@"var_titleColor"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detailColor"] forKey:@"var_detailColor"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"className"] forKey:@"var_className"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"select"] forKey:@"var_select"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"showPlay"] forKey:@"var_showPlay"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"hideStatus"] forKey:@"var_hideStatus"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pageNum"] forKey:@"var_pageNum"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"path"] forKey:@"var_path"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"kid"] forKey:@"var_kid"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_id"] forKey:@"var_app_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"] forKey:@"var_uid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"master"] forKey:@"var_master"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"face"] forKey:@"var_face"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"] forKey:@"var_mail"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"name"] forKey:@"var_name"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fav_plid"] forKey:@"var_fav_plid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s1"] forKey:@"var_s1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"val"] forKey:@"var_val"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"f1"] forKey:@"var_f1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"] forKey:@"var_fid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pid"] forKey:@"var_pid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"vp"] forKey:@"var_vp"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"link"] forKey:@"var_link"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"song_link"] forKey:@"var_song_link"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"song_text"] forKey:@"var_song_text"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mtext"] forKey:@"var_mtext"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mlink"] forKey:@"var_mlink"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tttext"] forKey:@"var_tttext"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ttlink"] forKey:@"var_ttlink"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text1"] forKey:@"var_text1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mlocklink"] forKey:@"var_mlocklink"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text2"] forKey:@"var_text2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ttlocklink"] forKey:@"var_ttlocklink"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_link"] forKey:@"var_app_link"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_text"] forKey:@"var_app_text"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appm_link"] forKey:@"var_appm_link"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appm_text"] forKey:@"var_appm_text"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"gd_nstll"] forKey:@"var_gd_nstll"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"d2"] forKey:@"var_d2"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"a1"] forKey:@"var_a1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"l1"] forKey:@"var_l1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"l2"] forKey:@"var_l2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"] forKey:@"var_t1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t2"] forKey:@"var_t2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"b1"] forKey:@"var_b1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"b2"] forKey:@"var_b2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t3"] forKey:@"var_t3"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t4"] forKey:@"var_t4"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k1"] forKey:@"var_k1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k2"] forKey:@"var_k2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"c4"] forKey:@"var_c4"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"c5"] forKey:@"var_c5"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"logo"] forKey:@"var_logo"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"update"] forKey:@"var_update"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"phone"] forKey:@"var_phone"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user_face"] forKey:@"var_user_face"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user_gender"] forKey:@"var_user_gender"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user_birth"] forKey:@"var_user_birth"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"] forKey:@"var_email"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user_issync2"] forKey:@"var_user_issync2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user_name"] forKey:@"var_user_name"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msync"] forKey:@"var_msync"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"] forKey:@"var_price"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k3"] forKey:@"var_k3"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k12"] forKey:@"var_k12"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"family"] forKey:@"var_family"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"account"] forKey:@"var_account"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"start"] forKey:@"var_start"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"inter"] forKey:@"var_inter"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"reward"] forKey:@"var_reward"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mrec"] forKey:@"var_mrec"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"banner"] forKey:@"var_banner"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"flag"] forKey:@"var_flag"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mid"] forKey:@"var_mid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mname"] forKey:@"var_mname"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"TTid"] forKey:@"var_TTid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"TTname"] forKey:@"var_TTname"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"TTeps"] forKey:@"var_TTeps"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"eps_id"] forKey:@"var_eps_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"jobid"] forKey:@"var_jobid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ss_id"] forKey:@"var_ss_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"url"] forKey:@"var_url"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"new_conf_type"] forKey:@"var_new_conf_type"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"movieId"] forKey:@"var_movieId"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"titleStr"] forKey:@"var_titleStr"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"imageUrl"] forKey:@"var_imageUrl"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"name2"] forKey:@"var_name2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s3"] forKey:@"var_s3"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s3img"] forKey:@"var_s3img"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"icon1"] forKey:@"var_icon1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"bundleid"] forKey:@"var_bundleid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"channelType"] forKey:@"var_channelType"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appbundleid"] forKey:@"var_appbundleid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appid"] forKey:@"var_appid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appleid"] forKey:@"var_appleid"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"appname"] forKey:@"var_appname"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"force"] forKey:@"var_force"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p1"] forKey:@"var_p1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p2"] forKey:@"var_p2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"] forKey:@"var_uid"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tempSelect"] forKey:@"var_tempSelect"];
    
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"index"] forKey:@"var_index"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"began"] forKey:@"var_began"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"subtitle"] forKey:@"var_subtitle"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"] forKey:@"var_title"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"titleFont"] forKey:@"var_titleFont"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"titleColor"] forKey:@"var_titleColor"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"scaleImage"] forKey:@"var_scaleImage"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"imageSize"] forKey:@"var_imageSize"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshButtonLabelEdgeInset"] forKey:@"var_refreshButtonLabelEdgeInset"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"needRefreshBtn"] forKey:@"var_needRefreshBtn"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshBtnTitle"] forKey:@"var_refreshBtnTitle"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshBtnTitleColor"] forKey:@"var_refreshBtnTitleColor"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshBtnTitleFont"] forKey:@"var_refreshBtnTitleFont"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshBtnAttributeTitle"] forKey:@"var_refreshBtnAttributeTitle"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"refreshBtnBackgroundColor"] forKey:@"var_refreshBtnBackgroundColor"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"clickOnRefreshButtonHandler"] forKey:@"var_clickOnRefreshButtonHandler"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"marginInfoToImage"] forKey:@"var_marginInfoToImage"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"marginBtnToInfo"] forKey:@"var_marginBtnToInfo"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"local"] forKey:@"var_local"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"server"] forKey:@"var_server"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"device"] forKey:@"var_device"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"val2"] forKey:@"var_val2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_os"] forKey:@"var_app_os"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"shelf"] forKey:@"var_shelf"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"] forKey:@"var_mail"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_name"] forKey:@"var_app_name"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k6"] forKey:@"var_k6"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k7"] forKey:@"var_k7"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k5"] forKey:@"var_k5"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ubt"] forKey:@"var_ubt"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"] forKey:@"var_t1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"logout"] forKey:@"var_logout"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"is_trial_period"] forKey:@"var_is_trial_period"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"is_in_intro_offer_period"] forKey:@"var_is_in_intro_offer_period"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"auto_renew_status"] forKey:@"var_auto_renew_status"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"apple_server_status"] forKey:@"var_apple_server_status"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tbu"] forKey:@"var_tbu"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"value"] forKey:@"var_value"];

    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"medit"] forKey:@"var_medit"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"cover"] forKey:@"var_cover"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"rate"] forKey:@"var_rate"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data_type"] forKey:@"var_data_type"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"eps_cnts"] forKey:@"var_eps_cnts"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pub_date"] forKey:@"var_pub_date"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ssn_id"] forKey:@"var_ssn_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"eps_list"] forKey:@"var_eps_list"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"stars"] forKey:@"var_stars"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tags"] forKey:@"var_tags"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"country"] forKey:@"var_country"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"quality"] forKey:@"var_quality"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ss_eps"] forKey:@"var_ss_eps"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"nw_flag"] forKey:@"var_nw_flag"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"best"] forKey:@"var_best"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"board"] forKey:@"var_board"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"sub"] forKey:@"var_sub"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"dub"] forKey:@"var_dub"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ep"] forKey:@"var_ep"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"age"] forKey:@"var_age"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"m_type_2"] forKey:@"var_m_type_2"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"v_360p"] forKey:@"var_v_360p"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"v_720p"] forKey:@"var_v_720p"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"v_1080p"] forKey:@"var_v_1080p"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"star_name"] forKey:@"var_star_name"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tt_id"] forKey:@"var_tt_id"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"ssn_list"] forKey:@"var_ssn_list"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"eps_num"] forKey:@"var_eps_num"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"rctInfo"] forKey:@"var_rctInfo"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"currentSRTModel"] forKey:@"var_currentSRTModel"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"subtitleTime"] forKey:@"var_subtitleTime"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"subtitleIndex"] forKey:@"var_subtitleIndex"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"step"] forKey:@"var_step"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"stepCurrentTime"] forKey:@"var_stepCurrentTime"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"stepMovieId"] forKey:@"var_stepMovieId"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"stepSessionId"] forKey:@"var_stepSessionId"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"stepLanguage"] forKey:@"var_stepLanguage"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"currentLanguageMdoel"] forKey:@"var_currentLanguageMdoel"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"timeshow"] forKey:@"var_timeshow"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"subtitleShow"] forKey:@"var_subtitleShow"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"languageDatasource"] forKey:@"var_languageDatasource"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"shouldOpen"] forKey:@"var_shouldOpen"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"inter_screen_ad_secs"] forKey:@"var_inter_screen_ad_secs"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"banner_ad_secs"] forKey:@"var_banner_ad_secs"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mbanner_secs"] forKey:@"var_mbanner_secs"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"play_lock_tlimit"] forKey:@"var_play_lock_tlimit"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"m1"] forKey:@"var_m1"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"i3"] forKey:@"var_i3"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"airplay"] forKey:@"var_airplay"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"applovin"] forKey:@"var_applovin"];
    [var_mapping setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"play_lock"] forKey:@"var_play_lock"];
    
    return var_mapping;
}
@end
