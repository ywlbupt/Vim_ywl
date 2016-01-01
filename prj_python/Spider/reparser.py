#! /usr/bin/env/python

import re

# question_link_re = re.compile(r'<a.*class\s*=\s*"question_link"\s*>(.*)</a>')
question_link_re =re.compile(r'''
        <h2\sclass="zm-profile-section-name">回答</h2>.*?
        <a.*?class\s*=\s*"question_link".*?
        href\s*=\s*"(?P<question_link>.*?)".*?>
        (?P<question_title>.*?)</a>.*?
        ''',re.X|re.S)

if __name__ == "__main__":
    with open ("./temp.txt",'r', encoding='utf-8') as fd :
       match =  question_link_re.findall(fd.read()) 
       if match:
           for item in match :
               print(item)
               # print(match.group(0))
               # print(match.group('question_title'))
