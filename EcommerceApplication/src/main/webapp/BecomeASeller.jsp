<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarzan Info Page</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Montserrat');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            height: 100%;
            background: linear-gradient(rgba(196, 102, 0, 0.6), rgba(155, 89, 182, 0.6));
        }

        body {
            font-family: 'Montserrat', Arial, Verdana;
        }

        #msform {
            width: 75%;
            margin: 50px auto;
            text-align: center;
            position: relative;
        }

        #msform fieldset {
            background: white;
            border: 0 none;
            border-radius: 3px;
            box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
            padding: 20px 30px;
            box-sizing: border-box;
            width: 80%;
            margin: 0 10%;
            position: absolute;
        }

        #msform fieldset:not(:first-of-type) {
            display: none;
        }

        #msform input, #msform textarea {
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-bottom: 10px;
            width: 100%;
            box-sizing: border-box;
            font-family: 'Montserrat';
            color: #2C3E50;
            font-size: 13px;
        }

        #msform .action-button {
            width: 100px;
            background: #27AE60;
            font-weight: bold;
            color: white;
            border: 0 none;
            border-radius: 1px;
            cursor: pointer;
            padding: 10px;
            margin: 10px 5px;
            text-decoration: none;
            font-size: 14px;
        }

        #msform .action-button:hover, #msform .action-button:focus {
            box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
        }

        .fs-title {
            font-size: 15px;
            text-transform: uppercase;
            color: #2C3E50;
            margin-bottom: 10px;
        }

        .fs-subtitle {
            font-weight: normal;
            font-size: 13px;
            color: #666;
            margin-bottom: 20px;
        }

        #progressbar {
            margin-bottom: 30px;
            overflow: hidden;
            counter-reset: step;
        }

        #progressbar li {
            list-style-type: none;
            color: white;
            text-transform: uppercase;
            font-size: 9px;
            width: 33.33%;
            float: left;
            position: relative;
        }

        #progressbar li:before {
            content: counter(step);
            counter-increment: step;
            width: 20px;
            line-height: 20px;
            display: block;
            font-size: 10px;
            color: #333;
            background: white;
            border-radius: 3px;
            margin: 0 auto 5px auto;
        }

        #progressbar li:after {
            content: '';
            width: 100%;
            height: 2px;
            background: white;
            position: absolute;
            left: -50%;
            top: 9px;
            z-index: -1;
        }

        #progressbar li:first-child:after {
            content: none;
        }

        #progressbar li.active:before, #progressbar li.active:after {
            background: #27AE60;
            color: white;
        }

        .tacbox {
            display: block;
            padding: 1em;
            margin: 2em 0;
            border: 3px solid #ddd;
            background-color: #eee;
            max-width: 800px;
        }

        .tacbox input {
            height: 2em;
            width: 2em;
            vertical-align: middle;
        }

        .tacbox a {
            color: #27AE60;
            text-decoration: none;
        }

        .tacbox a:hover {
            text-decoration: underline;
        }

        .content {
            text-align: left;
        }

        .content h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .content p {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .submit.action-button {
            display: none;
        }

        .tacbox input:checked ~ .submit.action-button {
            display: inline-block;
        }
        
    </style>
</head>
<body>

    <div id="msform">
        <!-- progressbar -->
        <ul id="progressbar">
            <li class="active">About Amazon</li>
            <li>Terms and Conditions</li>
            <li>Confirmation</li>
        </ul>
        
        <!-- fieldsets -->
        <fieldset>
            <h2 class="fs-title">About Amazon</h2>
            <h3 class="fs-subtitle">Learn more about us</h3>
            <div class="content">
                <h2>About Us</h2>
                <p>Amazon is a multinational technology company focusing on e-commerce, cloud computing, and artificial intelligence. Founded by Jeff Bezos on July 5, 1994, Amazon is now one of the world's largest online marketplaces, AI assistants, and cloud computing platforms, measured by revenue and market capitalization.</p>
                <p>Amazon started as an online bookstore but soon diversified to sell electronics, software, video games, apparel, furniture, food, toys, and jewelry. Today, Amazon operates multiple international websites and provides a wide range of services, including Amazon Prime, Amazon Web Services (AWS), and Amazon Echo.</p>
            </div>
            <input type="button" name="next" class="next action-button" value="Next" />
        </fieldset>
        
        <fieldset>
            <h2 class="fs-title">Terms and Conditions</h2>
            <h3 class="fs-subtitle">Please review our terms and conditions</h3>
            <div class="content">
                <h2>Terms and Conditions</h2>
                <p>Welcome to Amazon. By using Amazon Services, you agree to be bound by these terms. If you do not agree with any part of these terms, you must not use our services.</p>
                <p>These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and Amazon.com, Inc., concerning your access to and use of the Amazon website as well as any other media form, media channel, mobile website, or mobile application related, linked, or otherwise connected thereto (collectively, the “Site”).</p>
                <p>You agree that by accessing the Site, you have read, understood, and agreed to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the Site and you must discontinue use immediately.</p>
            </div>
            <input type="button" name="previous" class="previous action-button" value="Previous" />
            <input type="button" name="next" class="next action-button" value="Next" />
        </fieldset>
        
        <fieldset>
            <h2 class="fs-title">Confirmation</h2>
            <h3 class="fs-subtitle">Become a member</h3>
            <div class="content">
                <p>On becoming a member, you must accept the terms and conditions.</p>
                <form action="SellerLogin.jsp" method="POST">
                    <div class="tacbox">
                        <input id="checkbox" type="checkbox" />
                        <label for="checkbox"> I agree to these <a href="#">Terms and Conditions</a>.</label>
                        <button type="submit" class="submit action-button">Submit</button>
                    </div>
                </form>
                
            </div>
            <input type="button" name="previous" class="previous action-button" value="Previous" />
        </fieldset>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var current_fs, next_fs, previous_fs; // fieldsets
            var animating = false; // flag to prevent quick multi-click glitches
    
            $(".next").click(function() {
                if (animating) return false; // Check if currently animating, return if true
                animating = true; // Set animating to true to prevent multiple clicks
    
                current_fs = $(this).parent();
                next_fs = $(this).parent().next();
    
                $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
    
                next_fs.show(); // Show the next fieldset
                current_fs.hide(); // Hide the current fieldset
    
                animating = false; // Reset animating to false after animation completes
            });
    
            $(".previous").click(function() {
                if (animating) return false; // Check if currently animating, return if true
                animating = true; // Set animating to true to prevent multiple clicks
    
                current_fs = $(this).parent();
                previous_fs = $(this).parent().prev();
    
                $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
    
                previous_fs.show(); // Show the previous fieldset
                current_fs.hide(); // Hide the current fieldset
    
                animating = false; // Reset animating to false after animation completes
            });
      
   

    $("#checkbox").change(function() {
        if (this.checked) {
            $(".submit.action-button").show();
        } else {
            $(".submit.action-button").hide();
        }
    });
});

</script>

</body>
</html>
    