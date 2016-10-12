#!/bin/bash
# www.garanet.net
# https://github.com/garanet/svn_backup_s3.git

# Define variable
date='date +%Y-%m-%d'
tmp=/tmp/${date}
svn_path=''
email=''
# If you want to upload your backup to S3, make sure your server has the right pub key to connect to AWS .
account-aws=''

# Start the job
mkdir ${tmp}
cd ${svn_path}

# START BACKUP
for dir in *
do
        basefoldername=`basename ${dir}_${date}`
        tarfile="${basefoldername}.tar.gz"
        tar czf /${tmp}/${tarfile} ${dir}
        
        # Upload files to S3 account ? uncomment the follow 5 rows
        #/usr/local/bin/s3cmd put /${tmp}/${tarfile} s3://${account-aws}/svn_backup/${date}/${tarfile}
        #wait
        #echo ${tarfile} >> /tmp/svn_backup
        #sleep 3
        #rm  ${tmp}/${tarfile}
done
        mail -s "SVN BACKUP DONE" -t ${email} < /tmp/svn_backup
        rm /tmp/svn_backup
        rm -R ${tmp}
        exit 0;
# END
