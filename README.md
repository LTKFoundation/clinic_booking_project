### www.datkham.online

Datkham.online is a Ruby on Rails application that allows users to easily find clinic and doctor that is best suitable for their needs.
The key features of the system are:
1. UI was designed for a most pleasant using experience on Mobile.
2. Location based content enabled for easiest searching method. 
3. Information are presented clearly and concise. Allows user to see the most relevant information with the least effort
4. Allows users to give comment/rating for Doctor/Clinic so that all Users can preview the quality of Doctor/Clinic before using their service.
5. Allows users to book for a reserve timeslot.
6. Allows doctor to have a better insight about their upcoming client.
7. Allows doctor with less reputation to gain more clients 
Ultimately, the system aims to get rid of the hassle of coming directly to the clinic just to get the queue number ticket. 
We also hope to reduce wait time at each clinic, everyone benefits from a less crowded clinic. User doesn't have to spend hours waiting just to get a 5 minutes health check. 

Submitted by: Datkham.online team

User survey: [UserSurvey.csv](/UserSurvey.csv)

### User Stories
=====PHASE 0=====
#*_Guest_*

1. Search for doctors using any of the following query conditions:
	*. Doctor's Name
	*. Clinic's Name
	*. Clinic's Address
	*. Topic (that relates to Doctor's expertise). E.g: search for "examine child's fever" bring up list of Doctors that are specialized in Pediatric.
	*. Open time. E.g: search for Doctor that provide service at 8pm tomorrow.
	*. By default, system shows all doctors with default sorting conditions.
2. Sorting doctors with the following conditions:
	a. Nearest distance to current location. In this first phase, we focus on Saigon and Hanoi.
		i. Current location is detected automatically if allowed.
		ii. Input current location manually.
	b. Expertise of Doctor. For this first phase, we focus on Pediatric (nhi khoa) and Obstetrics (sản khoa).
	c. Opening time of the clinic (where the desired Doctor works).
	d. Price range of deposit cost for booking.
	e. By default, system sort doctors by nearest distance (if allowed), soonest available opening time, higher Up vote Doctor first. 
3. For each Doctor being display ON THE RESULT PAGE (defaul/after search/after sort), the following information are shown:
	*. Clinic's Name (Note to team: ussually Doctor will use their name as the clinic name. E.g: "Phòng khám bác sĩ Hùng").
	*. Doctor's Name.
	*. Doctor's expertise.
	*. Next opentime (day, time) NEXT TO A "BOOK NOW" button.
	*. Service price (for checkup only).
	*. Clinic's Address. NEXT TO A "SHOW MAP" button.
	*. Current rating result (Average rate) and Total Number of Comment (Click on total Number of Comment show Doctor details page with comment section opended).
4. View a Doctor's Profile (described in Doctor Stories below) 
5. Register to become *_User_* Only User can Vote/Comment on a Doctor and Book for a checkup. 
	a. Guest can chose to register using: Facebook OR Google OR Phone number
	b. After FB/G/Phone authentication, the additional info for User to input are(optional):
		*. Display name. By default, we fill in this form with data receive from authentication step (Name OR Email OR SMS). User can edit this to their preferred value.
		*. Citis where User lives.
		*. Payment information (Optional until they want to BOOK)
		*. Date of Birth
		*. Gender
		*. Address

#*_User_*

1. Rate a doctor 1-5. With a 1-3 rating, require to input a Comment.
2. Write a Comment on a Doctor's Profile.
3. Book for a timeslot in the upcoming Opening day of a selected Doctor:
	a. When viewing the Opening schedule of a Doctor, system allows User to see which timeslot are reserved and which are still available for booking.
	b. User click on the timeslot they prefer. System shows the Booking Info Page.
	c. The Booking Info Page shows:
		*.
		*.
		*. BOOK NOW button. 
	d. When click on BOOK NOW. 
		** If there is NO payment method saved: User is required to enter payment method.
			i. After input payment method. User click PAY NOW to start payment process.
			ii. Payment fails. Go back to input payment method form.
			iii. When payment succeed: Display success booking page with booking information including BOOKING NUMBER. Send BOOKING NUMBER to User's email AND/OR SMS.
			iv. On success booking page. Allows User to "save this payment method for future use". If User chose this:
				iv.1. Requires to enter a phone number (if User was not created by phone number). (EXPLAIN: This is to protect User in case they lost their FB/G account. Anyone control their FB/G account now can access to our site, but can only do payment if they can hack User SMS communication too).
				iv.2. Systems send verification code to User Phone number.
				iv.3. User enter verification code into System. If matched. Payment information is saved into database.  
		** If there is payment method saved:
			i. Inform User that they have a payment method already added. A verification code will be sent to the registered number(masking number with ****, only shows the first 3 digits and the last 3 digits) 
			ii. If User enter correct verification code. Load payment information.
			iii. If User lost their phone number or chose to use a new payment method. Bring up Input payment method form.    
4.  Use BOOKING NUMBER at Clinic.
	a. When User arrives at the Clinic, show Doctor/staff the BOOKING NUMBER to be serve at the reserved time.
	b. Doctor/staff input BOOKING NUMBER into System. Receive information about booking. Click on "CLIENT ARRIVED" button. BOOKING STATUS is now ARRIVED. 
	c. When requires to pay the checkup service fee (as listed on our system). User only has to pay the remainder of Checkup Fee - Booking cost (deposit).
	d. After receiving checkup service. User can give feedback about service given:
		i. Uber style -> scale from 1-5. With 5 is most happy. If rating is 1-3. Requires to input a reason. (NOTE TO TEAM: later on when we have bigger data of rate, change frontpage display to show Rate with actual booking).
		ii. Once feedback is submitted. BOOKING STATUS changes to FINISHED.
		iii. If User doesn't feedback. After 12 hours of BOOKING TIME. System sends email/sms to ask about the service received. Message content a link to the rating page. The message also says that if User does not response, system will flag the BOOKING as FINISHED.
	e. If User arrives to the Clinic later than BOOKING timeslot:
		i. If Doctor allows re-arrangement/wait list: go to 4.b -> 4.c -> 4.d
		ii. If Doctor does not allow re-arrangement/wait list. BOOKING is treated as not show up.
	f. If User doesn't show up. After 12 hours of BOOKING TIME. System sends email/sms to ask about what happened? With a link for User to write their reason. Inform User that BOOKING STATUS is finished.
	g. If User arrives at the Clinic on time but was made wait over the booked time OR the Doctor can not provide the service AT ALL.
		i. On BOOKING INFO page. Allow User to REPORT BAD SERVICE. Recommend User to contact our hotline immediately to receive REFUNDS.
		ii. When contacted for REPORT BAD SERVICE. We contact client immediately and try to resolve with Doctor right away. (NOTE TO TEAM: A customer support DASHBOARD needed). 
	h. In case Doctor has sudden situation and can not provide service in booked time. User receive a notification via Emails/SMS. We process to REFUNDS the Booking Deposit.

#*_CLINIC_*
1. We pupulate a list of predefined Clinic available. Each clinic has the following info:
	*. Clinic's Name.
	*. Address.
	*. Phone Number.
	*. Location on Map.
	*. License number 
	*. System Admin account is set as Owner account of each Clinic.
(NOTE TO TEAM: for phase 1. We leave it this way. In later phase we will implement a better management function for Clinic Owner Account)

#*_DOCTOR_*
(NOTE TO TEAM: in production. At the begining we/our staff will be the one contacting Doctor and collect info and do 
all of the registration process for opening a doctor account/ clinic account)

1. Creates account using FB/G/Email. The registration form includes the following madantory fields:
		*. Email(get from authentication or manual input) *
		*. Phone number *
		*. Name * 
	After input, verify Doctor's Phone number.
	Additional information (can edit later)	
		*. Short introduction
		*. Expertise
		*. Experiences
		*. Certification
		*. Photo
2. Uploads certification documents for approval.
3. Select the Clinic where Doctor works at from existing list. If Clinic not exist. Create a Clinic account.
	a. Create Clinic with the following info:
		*. Clinic's Name.
		*. Address.
		*. Phone Number (can be and should be different from Doctor's verification phone number).
		*. Location on Map.
		*. License number.
	b. Doctor account is set as Owner account of this Clinic.
4. Create Opening Time Schedule at this Clinic (remember later on one Doctor can work at different Clinics on different days).
	a. Setups working days of the week. Set if these available days will repeat weekly
	b. Setups working hours of each day/everyday.
5. Setups booking fee (deposit amount ) at the selected Clinic. 
6. Define Service Cost for checkup.
7. Views rating result.
8. Views comment on my profile me.
9. Replies to comment from User.
10. Write "article" to publish on my profile page/public page.
11. Using Client Booking Dashboard:
	a. View the dahboard showing list of upcoming User and their booked timeslot.
	b. When there are client come without booking. Easily enter their name into the next available timeslot.
	c. When a User with BOOKING show up. 
		i. Enter their booking code to verify. If the code is correct. BOOKING TIME SLOT update status as "ARRIVED" (change color to green maybe)
		ii. If there is no information on User profile. Doctor can add the following additional (optional) info about User:
			*. Date of Birth
			*. Gender
			*. Address
	d. If a User not show up after BOOKED time has passed. Status of that timeslot update to not show up (color changes to RED)
12. View Reports:
	i. Summary Report showing all client served in day/week/month. Client are seperated by online booking and no booking
	ii. More additional report here...

#*_ADMIN_*
_CUSTOMER_SUPPORT_
* Review and approve registration of Doctor
* Remove spam review of User
* 
_SYSTEM_ADMIN_


//END OF PHASE 0
=====PHASE 1=====

* User can add multiple patient (wife,kid, etc..).
* Doctor can enter prescription given to a patient.
* User and Doctor can communicate directly via chat.
* User and Doctor can view treatment history.
* A clinic can add multiple doctors. Can add different calendar for each doctor.
* One doctor can chose to be working at different clinic in different time/day. 

=====PHASE 2=====
* User can request for and Doctor can provide home checkup service
* Open to all medical services 