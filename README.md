
# Bakobord, Bahasa Consonant Centric Mobile Software Keyboard


This project will compare Bahasa Consonant Centric Keyboard layout with Colemak and Qwerty keyboard. This research aimed better keyboard layout for mobile usage which most of the time will skip vocal character and use consonant only to type faster.

Research Question : 
- Can we design keyboard layout with mobile characteristic in mind for Bahasa short message spesific usage ?
- How we decide all alphabet position ?
- How the keyboard will performed compared to QWERTY ?
- How the keyboard will performed compared to Colemak ?
- Is user comfortable with the new keyboard ?

We use QWERTY and Colemak as comparator, because QWERTY is the most wide usage keyboard layout in the world and Colemak is the newest (and claimed as faster than QWERTY).

Methodology :
- Bahasa word acquired from this github https://github.com/lufias69/KBBI2/blob/master/cek_KBBI/dataKBBI.json. Then processed such as remove all A,I,U,E,O. Then count every consonant used for the whole dataset. Result : n,r,m,k,g,t,s,l,b,p,d,h,y,c,j,w,f,v,z,x,q
- User will test on 3 keyboards, first with colemak, then qwerty and lastly with our proposed layout. We track every user interaction with keyboard
- User will fill survey with 5 likert scale to know more about their experience
- User will send all tracked result to google realtime database
- We analyze Result

![alur](https://github.com/tdimk2023p/final-project-kurniadi92/assets/9148775/165bebc7-e451-4184-88ad-d0795e35ffb0)

![image](https://github.com/tdimk2023p/final-project-kurniadi92/assets/9148775/c5c60ea2-0ac8-4dff-b787-93ebf77b1f7c)

Subject of test :
- 13 Iphone User
- 5 Female, 13 Male
- QWERTY fluent user and have daily interaction with mobile keyboard
- Aged 15 until 40
- Female and Male

Result :
Our proposed keyboard work still can match Colemak performance but cannot match QWERTY keyboard performance
<img width="737" alt="Screenshot 2023-12-16 at 12 20 25 PM" src="https://github.com/tdimk2023p/final-project-kurniadi92/assets/9148775/a7f45f4b-fc17-429a-ba58-c66faca6aeba">

It is interesting to discuss Colemak and Bakobord, because these two keyboard layouts are not familiar to Indonesians. Bakobord, which we propose as a solution to the need for typing non-vocal words in Indonesian, is slightly in front in WPM with a value of 5.78 compared to Colemak which has a WPM value of 5.25. The average time needed to complete one test sentence also proves that the Bakobord we made is 13.17 seconds faster than the Colemak.

This proves that for an unfamiliar keyboard layout, Bakobord has better performance than Colemak. The only thing where Bakobord loses to colemak is in WER. In this metric, Colemak is 0.01 better with a value of 0.86 compared to Bakobord which recorded a value of 0.87. Even so, Bakobord has 4 test subjects without errors compared to Colemak which only has 3 subjects. The lowest results were in the QWERTY layout with only 2 test subjects successfully completing the test without any errors.

<img width="766" alt="Screenshot 2023-12-16 at 12 20 35 PM" src="https://github.com/tdimk2023p/final-project-kurniadi92/assets/9148775/c78a7a87-fb25-4f29-bfb9-3731162960a1">

In terms of UX, QWERTY is unbeatable, this is understandable because QWERTY has been introduced as the standard keyboard layout on all devices. Unfortunately, the Bakobord that we proposed only excels in comfort for 2-handed use. This is in accordance with the initial design of placing letters in a circle from the middle of the layer out to accommodate the maximum touch zone when typing with 2 hands.
But unfortunately, apart from the QWERTY layout, none of the 6 categories above can reach the minimum score of 3 for the Colemak and Bakobord layouts. This shows that neither of the Colemak and Bakobord are at a standard that is comfortable for first users to use. Even though we tried to improve the UX based on first-round tester feedback, it still didn't have the expected impact on user response when trying 2 unfamiliar keyboard layouts.



