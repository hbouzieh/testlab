$members = "Authenticated Users", "Interactive"
Remove-LocalGroupMember -Group 'Users' –Member $members
