truncate table smf_log_actions;
-- truncate table smf_log_activity;
truncate table smf_log_banned;
truncate table smf_log_boards;
truncate table smf_log_comments;
truncate table smf_log_digest;
-- truncate table smf_log_errors;
truncate table smf_log_floodcontrol;
truncate table smf_log_group_requests;
truncate table smf_log_karma;
truncate table smf_log_mark_read;
truncate table smf_log_member_notices;
truncate table smf_log_notify;
-- truncate table smf_log_online;
truncate table smf_log_packages;
truncate table smf_log_polls;
truncate table smf_log_reported;
truncate table smf_log_reported_comments;
truncate table smf_log_scheduled_tasks;
truncate table smf_log_search_messages;
truncate table smf_log_search_results;
truncate table smf_log_search_subjects;
truncate table smf_log_search_topics;
truncate table smf_log_spider_hits;
truncate table smf_log_spider_stats;
truncate table smf_log_subscribed;
truncate table smf_log_topics;

truncate table smf_attachments;

truncate table smf_polls;
truncate table smf_poll_choices;

-- remove all users (except root and the account all bots share)
delete from smf_members where id_member not in (1, 2);

-- remove theme settings for all users except root.
delete from smf_themes where id_member not in (-1, 0, 1);

-- we don't use truncate here so the auto_increment value persists.
delete from smf_messages;
delete from smf_topics;

-- keep the post count synchronised.
update smf_members set posts = (select sum(num_posts) from smf_boards) where id_member = 2;

-- send all private messages to root.
update smf_pm_recipients set id_member = 1;
