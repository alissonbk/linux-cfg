#/data/data/com.alissonbk.QualisApp/files/SQLite
adb exec-out run-as com.alissonbk.QualisApp cat files/SQLite/qualis-app.db > /tmp/qualis-app.db
adb exec-out run-as com.alissonbk.QualisApp cat files/SQLite/qualis-app.db-shm > /tmp/qualis-app.db-shm
adb exec-out run-as com.alissonbk.QualisApp cat files/SQLite/qualis-app.db-wal > /tmp/qualis-app.db-wal
