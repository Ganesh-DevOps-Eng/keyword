#!/bin/bash

# Remove existing files
rm -rf /home/devops_automation/Downloads/newly-registered-domains*
rm -rf "/home/devops_automation/keyword/domain-names.txt"

# Run robot framework script
python3 -m robot /home/devops_automation/keyword/keyword.robot
sleep 5

# Unzip downloaded files
unzip /home/devops_automation/Downloads/newly-registered-domains*.zip -d /home/devops_automation/keyword/

# Recipient email addresses
RECIPIENT_KEYWORD_FOUND="ashish.garg@matellio.com"
RECIPIENT_KEYWORD_NOT_FOUND="ganesh.jat@matellio.com"

# Set the email subject and body
SUBJECT_KEYWORD_FOUND="Keyword Found"
BODY_KEYWORD_FOUND="Keyword was found in domain-names.txt file."

SUBJECT_KEYWORD_NOT_FOUND="Keyword Not Found"
BODY_KEYWORD_NOT_FOUND="Keyword was not found in domain-names.txt file."

# Function to send email using Gmail SMTP
send_email() {
    local recipient="$1"
    local subject="$2"
    local body="$3"
    echo -e "From: ganeshjatgjms@gmail.com\nSubject: $subject\n$body" | ssmtp -v "$recipient"

}

# Replace 'your_keyword' with the actual keyword you are looking for
keyword="matellio"
file_path="/home/devops_automation/keyword/domain-names.txt"

if grep -q "$keyword" "$file_path"; then
    echo "Keyword found"
    send_email "$RECIPIENT_KEYWORD_FOUND" "$SUBJECT_KEYWORD_FOUND" "$BODY_KEYWORD_FOUND"
else
    echo "Keyword not found..."
    send_email "$RECIPIENT_KEYWORD_NOT_FOUND" "$SUBJECT_KEYWORD_NOT_FOUND" "$BODY_KEYWORD_NOT_FOUND"
fi

