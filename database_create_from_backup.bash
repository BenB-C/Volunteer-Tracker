createdb volunteer_tracker
psql volunteer_tracker < database_backup.sql
createdb -T volunteer_tracker volunteer_tracker_test
