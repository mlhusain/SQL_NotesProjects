Forgot Database password 
 Step-by-Step Fix (No Password Needed)
✅ 1. Locate pg_hba.conf
On most systems, it’s here:

pgsql
Copy
Edit
C:\Program Files\PostgreSQL\15\data\pg_hba.conf
(Replace 15 with your installed version if different.)

Tip: If you can't find it, open DBeaver → click the little gear icon → open PostgreSQL driver properties → find the data directory.

✅ 2. Edit pg_hba.conf
Right-click the file → Open with Notepad as Administrator.

Find this line:

css
Copy
Edit
host    all             all             127.0.0.1/32            md5
Change md5 to trust, like this:

css
Copy
Edit
host    all             all             127.0.0.1/32            trust
If you see IPv6 too (::1/128), change that line to trust as well.

Save the file.

✅ 3. Restart PostgreSQL
Here’s how:

Press Win + R, type services.msc, hit Enter.

Scroll down to find PostgreSQL (e.g., "PostgreSQL 15").

Right-click → Restart.

✅ 4. Open SQL Shell or DBeaver (no password needed)
Use username: postgres

Leave password blank

Click connect.

If successful, run this command immediately:
✅ 5. Re-secure pg_hba.conf
Go back to pg_hba.conf

Change trust back to md5

Save and restart PostgreSQL again
