<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Profile</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
	padding-top: 70px; /* Ensure the navbar doesn't overlap the content */
	font-family: 'Roboto', sans-serif;
}

.navbar {
	background-color: #232F3E;
	color: #ffffff;
}

.container {
	max-width: 600px;
	margin: auto;
	padding: 20px;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-control {
	margin-bottom: 15px;
}

.btn-primary {
	width: 100%;
}
</style>
<script>
    const stateCityData = {
    	    "Andhra Pradesh": [
    	        "Visakhapatnam", "Vijayawada", "Guntur", "Nellore", "Kurnool", "Rajahmundry", "Tirupati", "Kadapa", "Kakinada", 
    	        "Anantapur", "Chittoor", "Ongole", "Eluru", "Vizianagaram", "Tenali", "Proddatur", "Adoni", "Nandyal", "Machilipatnam",
    	        "Madanapalle", "Hindupur", "Srikakulam", "Bhimavaram", "Amalapuram", "Gudivada", "Tadipatri", "Chilakaluripet", "Anakapalle", "Dharmavaram"
    	    ],
    	    "Arunachal Pradesh": [
    	        "Itanagar", "Naharlagun", "Tawang", "Ziro", "Pasighat", "Aalo", "Tezu", "Bomdila", "Roing", "Namsai", 
    	        "Seppa", "Anini", "Khonsa", "Changlang", "Miao", "Nampong", "Hayuliang", "Tuting", "Yingkiong", "Mechuka",
    	        "Daporijo", "Along", "Naharlagun", "Bhalukpong", "Deomali", "Koloriang", "Nirjuli", "Kharsang", "Taliha", "Gandhigram"
    	    ],
    	    "Assam": [
    	        "Guwahati", "Silchar", "Dibrugarh", "Jorhat", "Nagaon", "Tinsukia", "Tezpur", "Bongaigaon", "Karimganj", "Sivasagar", 
    	        "Goalpara", "Hailakandi", "Barpeta", "Nalbari", "Morigaon", "Dhubri", "Diphu", "North Lakhimpur", "Dhemaji", "Dudhnai",
    	        "Bilasipara", "Margherita", "Lanka", "Abhayapuri", "North Guwahati", "Lumding", "Dhing", "Mariani", "Rangia", "Sorbhog"
    	    ],
    	    "Bihar": [
    	        "Patna", "Gaya", "Bhagalpur", "Muzaffarpur", "Darbhanga", "Bihar Sharif", "Arrah", "Begusarai", "Katihar", "Munger", 
    	        "Chapra", "Purnia", "Siwan", "Motihari", "Nawada", "Bagaha", "Buxar", "Kishanganj", "Saharsa", "Hajipur",
    	        "Dehri", "Gopalganj", "Jamalpur", "Lakhisarai", "Madhubani", "Masaurhi", "Mirganj", "Mokama", "Munger", "Narkatiaganj"
    	    ],
    	    "Chhattisgarh": [
    	        "Raipur", "Bilaspur", "Durg", "Bhilai", "Korba", "Raigarh", "Jagdalpur", "Rajnandgaon", "Ambikapur", "Chirmiri", 
    	        "Dhamtari", "Janjgir", "Kanker", "Mahasamund", "Dipka", "Bemetara", "Saraipali", "Baloda Bazar", "Bhatapara", "Jashpur",
    	        "Kawardha", "Kharsia", "Kondagaon", "Korba", "Mahendragarh", "Mungeli", "Naila Janjgir", "Sakti", "Saraipali", "Tilda"
    	    ],
    	    "Goa": [
    	        "Panaji", "Margao", "Vasco da Gama", "Mapusa", "Ponda", "Bicholim", "Curchorem", "Sanquelim", "Quepem", "Sanguem", 
    	        "Canacona", "Colva", "Cuncolim", "Dharbandora", "Mormugao", "Navelim", "Onda", "Pernem", "Sancoale", "Valpoi",
    	        "Arambol", "Chicalim", "Marcela", "Nuvem", "Panaji", "Pilerne", "Shiroda", "Tivim", "Usgao", "Verla"
    	    ],
    	    "Gujarat": [
    	        "Ahmedabad", "Surat", "Vadodara", "Rajkot", "Bhavnagar", "Jamnagar", "Junagadh", "Gandhinagar", "Nadiad", "Porbandar", 
    	        "Anand", "Surendranagar", "Bharuch", "Navsari", "Valsad", "Mehsana", "Bhuj", "Dahod", "Godhra", "Palanpur",
    	        "Amreli", "Bardoli", "Botad", "Chhota Udaipur", "Dang", "Deesa", "Dholka", "Gandhidham", "Himatnagar", "Jambusar"
    	    ],
    	    "Haryana": [
    	        "Chandigarh", "Gurugram", "Faridabad", "Hisar", "Panipat", "Ambala", "Karnal", "Rohtak", "Yamunanagar", "Sonipat", 
    	        "Panchkula", "Bhiwani", "Sirsa", "Jind", "Rewari", "Kaithal", "Palwal", "Bahadurgarh", "Hansi", "Narnaul",
    	        "Bilaspur", "Charkhi Dadri", "Dabwali", "Ellenabad", "Fatehabad", "Gharaunda", "Gohana", "Hansi", "Jagadhri", "Jhajjar"
    	    ],
    	    "Himachal Pradesh": [
    	        "Shimla", "Manali", "Dharamshala", "Solan", "Mandi", "Kullu", "Chamba", "Bilaspur", "Hamirpur", "Nahan", 
    	        "Una", "Palampur", "Kangra", "Parwanoo", "Mehatpur Basdehra", "Jogindernagar", "Nurpur", "Dalhousie", "Kasauli", "Rampur",
    	        "Banjar", "Chail", "Dalhousie", "Kaza", "Kotkhai", "Narkanda", "Reckong Peo", "Sundarnagar", "Tattapani", "Theog"
    	    ],
    	    "Jharkhand": [
    	        "Ranchi", "Jamshedpur", "Dhanbad", "Bokaro Steel City", "Deoghar", "Hazaribagh", "Giridih", "Ramgarh", "Chakradharpur", "Phusro", 
    	        "Medininagar", "Chaibasa", "Jhumri Tilaiya", "Gumla", "Lohardaga", "Simdega", "Pakur", "Jamtara", "Saunda", "Gumia",
    	        "Barhi", "Barkatha", "Bermo", "Bundu", "Chandil", "Chatra", "Chirkunda", "Daltonganj", "Gobindpur", "Godda"
    	    ],
    	    "Karnataka": [
    	        "Bengaluru", "Mysore", "Mangalore", "Hubli", "Belgaum", "Davangere", "Gulbarga", "Bellary", "Shimoga", "Tumkur", 
    	        "Udupi", "Bidar", "Hospet", "Hassan", "Raichur", "Chitradurga", "Kolar", "Ramanagara", "Bagalkot", "Chikkamagaluru",
    	        "Karwar", "Madikeri", "Mandya", "Nanjangud", "Puttur", "Robertsonpet", "Ranebennur", "Sagara", "Sirsi", "Sringeri"
    	    ],
    	    	    "Kerala": [
    	    	        "Thiruvananthapuram", "Kochi", "Kozhikode", "Thrissur", "Kollam", "Alappuzha", "Palakkad", "Malappuram", "Kottayam", "Kannur", 
    	    	        "Manjeri", "Kasaragod", "Nilambur", "Payyannur", "Ponnani", "Pathanamthitta", "Thalassery", "Perinthalmanna", "Thiruvalla", "Kodungallur",
    	    	        "Adoor", "Angamaly", "Chalakudy", "Changanassery", "Cherthala", "Kanhangad", "Kochi", "Kodungallur", "Kottakkal", "Kottarakkara"
    	    	    ],
    	    	    "Madhya Pradesh": [
    	    	        "Bhopal", "Indore", "Gwalior", "Jabalpur", "Ujjain", "Sagar", "Dewas", "Satna", "Ratlam", "Rewa", 
    	    	        "Chhindwara", "Guna", "Shivpuri", "Vidisha", "Damoh", "Mandsaur", "Khargone", "Neemuch", "Pithampur", "Itarsi",
    	    	        "Khandwa", "Hoshangabad", "Nagda", "Raisen", "Chhatarpur", "Burhanpur", "Sehore", "Mhow", "Harda", "Betul"
    	    	    ],
    	    	    "Maharashtra": [
    	    	        "Mumbai", "Pune", "Nagpur", "Nashik", "Thane", "Aurangabad", "Solapur", "Amravati", "Kolhapur", "Nanded", 
    	    	        "Sangli", "Satara", "Jalgaon", "Akola", "Dhule", "Ahmednagar", "Latur", "Chandrapur", "Parbhani", "Yavatmal",
    	    	        "Bhusawal", "Ichalkaranji", "Jalna", "Malegaon", "Nandurbar", "Osmanabad", "Wardha", "Baramati", "Gondia", "Beed"
    	    	    ],
    	    	    "Manipur": [
    	    	        "Imphal", "Churachandpur", "Bishnupur", "Thoubal", "Kakching", "Jiribam", "Moirang", "Nambol", "Ukhrul", "Senapati", 
    	    	        "Tamenglong", "Chandel", "Kangpokpi", "Moreh", "Lilong", "Sugnu", "Wangjing", "Sekmai", "Henglep", "Kumbi",
    	    	        "Mayang Imphal", "Noney", "Phungyar", "Shamurou", "Chakpikarong", "Sangaikot", "Tousem", "Khongman", "Lamshang", "Wangoi"
    	    	    ],
    	    	    "Meghalaya": [
    	    	        "Shillong", "Tura", "Jowai", "Nongstoin", "Baghmara", "Williamnagar", "Resubelpara", "Mairang", "Nongpoh", "Cherrapunjee", 
    	    	        "Amlarem", "Khliehriat", "Mawkyrwat", "Dawki", "Nongpoh", "Ranikor", "Jirang", "Balat", "Nartiang", "Sohra",
    	    	        "Mendipathar", "Mylliem", "Pynursla", "Shella", "Siju", "Tyrna", "Wahkhen", "War Jaintia", "War Khasi", "Mawlynnong"
    	    	    ],
    	    	    "Mizoram": [
    	    	        "Aizawl", "Lunglei", "Champhai", "Serchhip", "Kolasib", "Lawngtlai", "Saiha", "Mamit", "Biate", "Thenzawl", 
    	    	        "Khawzawl", "Hnahthial", "Sairang", "Saitual", "Zawlnuam", "Ngopa", "Nghalen", "Chawngte", "Thingsulthliah", "Zemabawk",
    	    	        "N. Vanlaiphai", "Nun Vansang", "N.Vanlaiphai", "Saiha", "Tlabung", "Tualbung", "Tlungvel", "Tuipang", "Tum", "Vairengte"
    	    	    ],
    	    	    "Nagaland": [
    	    	        "Kohima", "Dimapur", "Mokokchung", "Wokha", "Zunheboto", "Tuensang", "Mon", "Phek", "Chumukedima", "Kiphire", 
    	    	        "Kuda", "Longleng", "Meluri", "Noklak", "Peren", "Pfutsero", "Satakha", "Shamator", "Tseminyu", "Wokha",
    	    	        "Zunheboto", "Noklak", "Pughoboto", "Tamlu", "Tizit", "Tuli", "Tuensang", "Tseminyu", "Changtongya", "Chiephobozou"
    	    	    ],
    	    	    "Odisha": [
    	    	        "Bhubaneswar", "Cuttack", "Rourkela", "Berhampur", "Sambalpur", "Puri", "Brahmapur", "Bargarh", "Bhadrak", "Balasore", 
    	    	        "Baripada", "Jharsuguda", "Jeypore", "Kendrapara", "Rayagada", "Koraput", "Nabarangpur", "Paradip", "Phulabani", "Angul",
    	    	        "Balangir", "Boudh", "Debagarh", "Kandhamal", "Nayagarh", "Sundergarh", "Dhenkanal", "Anugul", "Asika", "Athagarh"
    	    	    ],
    	    	    "Punjab": [
    	    	        "Chandigarh", "Ludhiana", "Amritsar", "Jalandhar", "Patiala", "Bathinda", "Hoshiarpur", "Mohali", "Batala", "Pathankot", 
    	    	        "Moga", "Abohar", "Phagwara", "Muktsar", "Barnala", "Kapurthala", "Sangrur", "Firozpur", "Ropar", "Faridkot",
    	    	        "Fazilka", "Gurdaspur", "Malout", "Nabha", "Patti", "Rajpura", "Sultanpur Lodhi", "Tarn Taran", "Zira", "Chheharta"
    	    	    ],
    	    	    "Rajasthan": [
    	    	        "Jaipur", "Udaipur", "Jodhpur", "Ajmer", "Kota", "Bikaner", "Bhilwara", "Alwar", "Sikar", "Pali", 
    	    	        "Sawai Madhopur", "Tonk", "Chittorgarh", "Bharatpur", "Baran", "Jhunjhunu", "Dausa", "Nagaur", "Banswara", "Churu",
    	    	        "Bhilwara", "Hanumangarh", "Rajsamand", "Sardarshahar", "Bhiwadi", "Dholpur", "Sri Ganganagar", "Hindaun", "Falna", "Kishangarh"
    	    	    ],
    	    	    "Sikkim": [
    	    	        "Gangtok", "Namchi", "Pelling", "Gyalshing", "Jorethang", "Mangan", "Rangpo", "Soreng", "Sikkim", "Singtam", 
    	    	        "Dikchu", "Gyalshing", "Jorethang", "Legship", "Mangan", "Namchi", "Naya Bazar", "Pakyong", "Rhenak", "Rongli"
    	    	    ],
    	    	    	    "Tamil Nadu": [
    	    	    	        "Chennai", "Coimbatore", "Madurai", "Tiruchirappalli", "Salem", "Tiruppur", "Erode", "Vellore", "Thoothukudi", "Tirunelveli", 
    	    	    	        "Dindigul", "Thanjavur", "Ranipet", "Sivakasi", "Karur", "Ooty", "Pollachi", "Rajapalayam", "Nagercoil", "Kanchipuram",
    	    	    	        "Hosur", "Neyveli", "Nagapattinam", "Vaniyambadi", "Tiruvannamalai", "Pudukkottai", "Krishnagiri", "Arakkonam", "Virudhachalam", "Ambur"
    	    	    	    ],
    	    	    	    "Telangana": [
    	    	    	        "Hyderabad", "Warangal", "Nizamabad", "Karimnagar", "Ramagundam", "Khammam", "Mahbubnagar", "Nalgonda", "Adilabad", "Suryapet", 
    	    	    	        "Miryalaguda", "Jagtial", "Vikarabad", "Siddipet", "Wanaparthy", "Kothagudem", "Nirmal", "Kamareddy", "Bodhan", "Palwancha",
    	    	    	        "Jangaon", "Bhongir", "Bellampalle", "Sangareddy", "Mancherial", "Kagaznagar", "Mandamarri", "Koratla", "Sircilla", "Tandur"
    	    	    	    ],
    	    	    	    "Tripura": [
    	    	    	        "Agartala", "Dharmanagar", "Udaipur", "Ambassa", "Kailasahar", "Belonia", "Santir Bazar", "Khowai", "Sonamura", "Teliamura", 
    	    	    	        "Sabroom", "Amarpur", "Kamalpur", "Kanchanpur", "Kumarghat", "Mohanpur", "Panisagar", "Jirania", "Bishramganj", "Kadamtala Kailashahar",
    	    	    	        "Ranir Bazar", "Shantir Bazar", "Kailashahar", "Kanchanpur", "Khowai", "Kumarghat", "Santirbazar", "Teliamura", "Udaipur"
    	    	    	    ],
    	    	    	    "Uttar Pradesh": [
    	    	    	        "Lucknow", "Kanpur", "Ghaziabad", "Agra", "Meerut", "Varanasi", "Allahabad", "Bareilly", "Aligarh", "Moradabad", 
    	    	    	        "Saharanpur", "Gorakhpur", "Noida", "Firozabad", "Jhansi", "Muzaffarnagar", "Mathura", "Budaun", "Rampur", "Shahjahanpur",
    	    	    	        "Farrukhabad", "Hapur", "Etawah", "Mirzapur", "Bulandshahr", "Sambhal", "Amroha", "Hardoi", "Fatehpur", "Raebareli"
    	    	    	    ],
    	    	    	    "Uttarakhand": [
    	    	    	        "Dehradun", "Haridwar", "Roorkee", "Haldwani", "Rudrapur", "Kashipur", "Rishikesh", "Pithoragarh", "Ramnagar", "Manglaur", 
    	    	    	        "Kotdwara", "Mussoorie", "Bageshwar", "Tehri", "Pauri", "Sitarganj", "Jaspur", "Bajpur", "Jhabrera", "Sultanpur",
    	    	    	        "Jaspur", "Muni Ki Reti", "Nagla", "Barkot", "Bhagwanpur", "Chamba", "Dhandera", "Dharchula", "Didihat", "Doiwala"
    	    	    	    ],
    	    	    	    "West Bengal": [
    	    	    	        "Kolkata", "Howrah", "Asansol", "Siliguri", "Durgapur", "Bardhaman", "Malda", "Baharampur", "Kharagpur", "Haldia", 
    	    	    	        "Raiganj", "Krishnanagar", "Medinipur", "Jalpaiguri", "Balurghat", "Basirhat", "Bankura", "Chandannagar", "Cooch Behar", "Darjeeling",
    	    	    	        "Alipurduar", "Purulia", "Jangipur", "Kalimpong", "Barasat", "Bangaon", "Kalyani", "Serampore", "Barrackpore", "Gangarampur"
    	    	    	    ]
    	    	    	};


        // Function to populate cities based on state selection
        function updateCityDropdown() {
            const stateSelect = document.getElementById("state");
            const citySelect = document.getElementById("city");
            const selectedState = stateSelect.value;

            // Clear previous cities
            citySelect.innerHTML = "";

            // Populate new cities
            if (selectedState) {
                const cities = stateCityData[selectedState];
                for (const city of cities) {
                    const option = document.createElement("option");
                    option.value = city;
                    option.textContent = city;
                    citySelect.appendChild(option);
                }
            }
        }

        // Function to validate the pincode input
        function validatePincode() {
            const pincodeInput = document.getElementById("pincode");
            pincodeInput.setCustomValidity("");
            if (pincodeInput.value.length !== 6) {
                pincodeInput.setCustomValidity("Pincode must be 6 digits.");
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            // Add event listener for state dropdown change
            document.getElementById("state").addEventListener("change", updateCityDropdown);

            // Add event listener for pincode input
            document.getElementById("pincode").addEventListener("input", validatePincode);
        });
    </script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">YourSite</a>
		</div>
	</nav>

	<div class="container mt-5">
		<h2 class="mb-4">Address details for Your orders</h2>
		<form action="ProfileServlet" method="POST">
			<div class="form-group">
				<label for="user_id">User ID</label> <input type="text"
					class="form-control" id="user_id" name="user_id" required >
			</div>
			<div class="form-group">
				<label for="first_name">First Name</label> <input type="text"
					class="form-control" id="first_name" name="first_name" required pattern="[a-zA-Z_]{3,20}">
			</div>
			<div class="form-group">
				<label for="last_name">Last Name</label> <input type="text"
					class="form-control" id="last_name" name="last_name" required pattern="[a-zA-Z_]{3,20}">
			</div>
			<div class="form-group">
				<label for="address">Address</label> <input type="text"
					class="form-control" id="address" name="address" required pattern=".{3,100}">
			</div>
			<div class="form-group">
				<label for="state">State</label> <select class="form-control"
					id="state" name="state" required>
					<option value="">Select State</option>
					<%-- Populate state options --%>
					<%
					String[] states = { "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat",
							"Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
							"Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana",
							"Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal" };
					for (String state : states) {
					%>
					<option value="<%=state%>"><%=state%></option>
					<%
					}
					%>
				</select>
			</div>
			<div class="form-group">
				<label for="city">City</label> <select class="form-control"
					id="city" name="city" required>
					<option value="">Select City</option>
					<!-- Cities will be populated based on state selection -->
				</select>
			</div>
			<div class="form-group">
				<label for="pincode">Pincode</label> <input type="text"
					class="form-control" id="pincode" name="pincode" pattern="\d{6}"
					required>
			</div>
			<button type="submit" class="btn btn-primary">Add Profile</button>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
		
		 <script type="text/javascript">
        var updateStatus = '<%= request.getParameter("updateStatus") %>';

        if (updateStatus === 'success') {
            Swal.fire({
                icon: 'success',
                title: 'Profile Updated Successfully!',
                text: 'Your profile has been updated successfully.',
                allowOutsideClick: false
            });
        } else if (updateStatus === 'failure') {
            Swal.fire({
                icon: 'error',
                title: 'Failed to Update Profile!',
                text: 'Something went wrong while updating your profile. Please try again later.',
                allowOutsideClick: false
            });
        }
    </script>
</body>
</html>
