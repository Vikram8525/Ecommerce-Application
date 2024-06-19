<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.Base64, java.sql.*, java.io.*, java.util.*, com.chainsys.finalproject.util.Connectivity"%>
<%@page import="com.chainsys.finalproject.model.User"%>
<%
User user = (User) session.getAttribute("user");
boolean isLoggedIn = (user != null);

int cartItemCount = 0;
if (isLoggedIn) {
	int userId = user.getUserId();
	try (Connection conn = Connectivity.getConnection()) {
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM Cart WHERE user_id = ? and is_bought = 0");
		stmt.setInt(1, userId);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
	cartItemCount = rs.getInt(1);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
int wishlistItemCount = 0;
if (isLoggedIn) {
	int userId = user.getUserId();
	try (Connection conn = Connectivity.getConnection()) {
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM wishlist WHERE user_id = ?");
		stmt.setInt(1, userId);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
	wishlistItemCount = rs.getInt(1);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home Page</title>
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
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&display=swap"
	rel="stylesheet">
<style>
        body {
            padding-top: 70px; 
            font-family: 'Roboto', sans-serif;
        }
         
        .navbar {
            background-color: #232F3E;
            color: #ffffff;
        }
        .navbar .navbar-brand,
        .navbar .nav-link {
            color: #ffffff;
        }
        #nav-logo-sprites {
            display: flex;
            align-items: center;
        }
        #nav-logo-sprites img {
            height: 40px; 
            margin-right: 1px; 
        }
        #glow-ingress-block {
            font-family: 'Roboto', sans-serif;
            color: #ffffff;
            display: flex;
            align-items: center;
            margin-left: 5px;
        }
        #glow-ingress-block i {
            font-size: 2rem; 
            margin-right: 10px;
            color: #ffffff; 
        }
        #location-form .btn {
            background-color: transparent;
            border: none;
            color: #ffffff; 
        }
        #location-form .btn:hover {
            color: #febd69; 
        }
        #location i {
            font-size: 2rem;
        }
        .nav-item .nav-link {
            color: #ffffff;
        }
        .nav-item .nav-link:hover {
            color: #dddddd;
        }
        .btn-outline-success {
            color: #ffffff;
            border-color: #febd69;
        }
        .btn-outline-success:hover {
            background-color: #febd69;
            color: #232F3E;
        }
        .nav-icons {
            display: flex;
            align-items: center;
        }
        .nav-icons .btn {
            margin-left: 10px;
            color: #ffffff;
            background-color: #232F3E;
            border: none;
        }
        .nav-icons .btn:hover {
            color: #febd69;
        }
        .form-control {
            background-color: #fff;
            color: #000;
            width: 200px; 
        }
        .nav-logo-locale {
            padding-left: 1px; 
            padding-bottom: 6px;
        }
        
        .category-grid {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: 50px;
        }
        .category-card {
            position: relative;
            width: 16%;
            padding-bottom: 15%;
            border-radius: 0%;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .category-card:hover {
            transform: translateY(-35px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        .category-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 0;
            border-radius: 0%;
        }
        .event-info {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 10px;
            background-color: rgba(0, 0, 0, 0.6);
            color: #fff;
            transition: transform 0.3s ease;
            transform: translateY(100%);
            border-radius: 0 0 0% 0%;
        }
        .category-card:hover .event-info {
            transform: translateY(0);
        }
        .event-info h3 {
            margin: 0;
            margin-bottom: 5px;
            font-size: 16px; 
        }
        .event-info p {
            margin: 0;
            margin-bottom: 10px;
            font-size: 14px; 
        }
         * {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
      box-sizing: border-box;
      
    }
    
    .container1 {
      height: 50vh; /* Half the height of the viewport */
      overflow: hidden;
      position: relative;
      background: url('https://img.freepik.com/free-photo/cityscape-anime-inspired-urban-area_23-2151028574.jpg');
      background-size: cover;
      background-position: center;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .banner {
      position: relative;
      height: 100%;
      width: 100%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      overflow: hidden;
    }
    h5 {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: .5;
      color: #fff;
      font-size: 0.75rem; /* Adjusted font size */
      text-align: center;
    }
    h5 img {
      display: block;
      width: 700px; /* Adjust image size as needed */
      height: auto;
      margin-bottom: 5px; /* Spacing between image and text */
    }
    .clouds {
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      width: 100%;
      pointer-events: none;
    }
    .clouds img {
      position: absolute;
      bottom: 0;
      max-width: 100%;
      z-index: 1; /* Ensure clouds are behind h5 content */
      animation: animate calc(2s * var(--i)) linear infinite;
    }
    @keyframes animate {
      0% {
        opacity: 0;
        transform: scale(1);
      }
      25%, 75% {
        opacity: 1;
      }
      100% {
        opacity: 0;
        transform: scale(3);
      }
    }
    section {
      padding: 20px 40px;
    }
    section h1 {
      font-size: 4rem;
      margin-bottom: 20px;
    }
    @media screen and (max-width: 1000px) {
      h2 {
        font-size: 8rem;
      }
      h1 {
        font-size: 2rem;
      }
    }
    @media screen and (max-width: 800px) {
      h2 {
        font-size: 6rem;
      }
    }
    @media screen and (max-width: 600px) {
      h2 {
        font-size: 5rem;
      }
    }
    @media screen and (max-width: 400px) {
      h2 {
        font-size: 4rem;
      }
      
    }
    </style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
		<div class="container-fluid">
			<div class="nav-left d-flex">
				<div id="nav-logo">
					<a href="#" id="nav-logo-sprites" class="navbar-brand"> <img
						src="homeImage/logo1.png" alt="Logo"> <span id="logo-ext"
						class="nav-sprite nav-logo-ext"></span> <span
						class="nav-logo-locale">.in</span>
					</a>
				</div>
				<div id="location">
					<i class="fa fa-map-marker" aria-hidden="true"></i>
				</div>
				<div id="glow-ingress-block">
					<%
					if (isLoggedIn) {
					%>
					<%=user.getAddress()%>
					<%
					}
					%>
				</div>
			</div>

			<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
				<form class="d-flex mx-auto" action="SearchServlet" method="POST"
					role="search">
					<input class="form-control me-2" name="searchValue" type="search"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>


				<div class="nav-icons">
					<%
					if (isLoggedIn && user.isSeller()) {
					%>
					<form action="SellerViewProducts.jsp">
						<button class="btn btn-secondary" type="submit" name="add_product">
							<i class="fa fa-plus"></i> Add Product
						</button>
					</form>
					<%
					}
					%>
					<%
					if (isLoggedIn && !user.isSeller()) {
					%>
					<form action="BecomeASeller.jsp">
						<button class="btn btn-secondary" type="submit"
							name="become_seller">Become a Seller</button>
					</form>
					<%
					}
					%>
					<%
					if (!isLoggedIn) {
					%>
					<form action="LoginForm.jsp">
						<button class="btn btn-secondary" type="submit"
							name="login_signup">Login/Sign Up</button>
					</form>
					<%
					} else {
					%>
					<form action="LogoutServlet" method="post">
						<button class="btn btn-secondary" type="submit" name="logout">Logout</button>
					</form>
					<%
					}
					%>
					<form action="UserDetail.jsp">
						<button class="btn btn-secondary" type="submit" name="profile">
							<i class="fa fa-user-plus"></i>
						</button>
					</form>
					<form action="ViewCart.jsp">
						<button class="btn btn-secondary" type="submit" name="cart">
							<i class="fa fa-shopping-cart"></i>
						</button>
					</form>
					<form action="ViewWishlist.jsp">
						<button class="btn btn-secondary" type="submit" name="wishlist">
							<i class="fa fa-heart-o"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</nav>


	<div class="container1">
		<div class="banner">
			<h5>
				<img src="homeImage/logo1.png" alt="Logo ">Logo Text
			</h5>
			<div class="clouds">
				<img src="https://i.postimg.cc/PrMrJc9d/cloud1.png" style="--i: 1"
					alt="cloud 1 "> <img
					src="https://i.postimg.cc/fRTW9CQm/cloud2.png" style="--i: 2"
					alt="cloud 2 "> <img
					src="https://i.postimg.cc/sg6j9W38/cloud3.png" style="--i: 3"
					alt="cloud 3 "> <img
					src="https://i.postimg.cc/sg6j9W38/cloud3.png" style="--i: 8"
					alt="cloud 4 ">
			</div>
		</div>
	</div>

	<div class="container">
		<div class="category-grid">
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit" name="productType" value="watch"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img src="homeImage/Watch.jpg" alt="Watch">
					<div class="event-info">
						<h3>Watch</h3>
						<p>Latest Collection</p>
					</div>
				</button>
			</form>
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit" name="productType" value="shoes"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img src="homeImage/Shoes.jpg" alt="Shoes">
					<div class="event-info">
						<h3>Shoes</h3>
						<p>Comfort and Style</p>
					</div>
				</button>
			</form>
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit" name="productType"
					value="anime_action_figures"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img src="homeImage/Anime 1.jpg" alt="Anime Action Figure">
					<div class="event-info">
						<h3>Anime Action Figure</h3>
						<p>For Collectors</p>
					</div>
				</button>
			</form>
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit" name="productType" value="headset"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img src="homeImage/Headphone.jpg" alt="Headphone">
					<div class="event-info">
						<h3>Headphone</h3>
						<p>Top Quality Sound</p>
					</div>
				</button>
			</form>
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit" name="productType" value="mobile_phone"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img src="homeImage/Phone.jpg" alt="Mobile Phone">
					<div class="event-info">
						<h3>Mobile Phone</h3>
						<p>Latest Technology</p>
					</div>
				</button>
			</form>
			<form action="ViewProduct.jsp" method="get" class="category-card">
				<button type="submit"
					style="background: none; border: none; padding: 0; width: 100%; height: 100%;">
					<img
						src="https://img.freepik.com/free-vector/sale-banner_23-2148120029.jpg?ga=GA1.1.1636780205.1718340265&semt=ais_user"
						alt="All Products">
					<div class="event-info">
						<h3>All Products</h3>
						<p>Browse All Items</p>
					</div>
				</button>
			</form>
		</div>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
        <%if (request.getAttribute("status") != null) {%>
            var status = '<%=request.getAttribute("status")%>';
            var message = '<%=request.getAttribute("message")%>';

            if (status === "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'Profile Updated Successfully!',
                    text: message
                });
            } else if (status === "error") {
                Swal.fire({
                    icon: 'error',
                    title: 'Failed to Update Profile!',
                    text: message
                });
            }
        <%}%>
    </script>
	<script>
        document.addEventListener('DOMContentLoaded', function () {
            function updateCartNotification(count) {
                const cartButton = document.querySelector('.fa-shopping-cart');
                if (count > 0) {
                    const notification = document.createElement('span');
                    notification.className = 'cart-notification';
                    notification.textContent = count;
                    cartButton.parentElement.appendChild(notification);
                }
            }
            
            updateCartNotification(<%=cartItemCount%>); // Update cart count on page load
        });
        
        function updateWishlistNotification(count) {
            const wishlistButton = document.querySelector('.fa-heart-o');
            if (count > 0) {
                const notification = document.createElement('span');
                notification.className = 'wishlist-notification';
                notification.textContent = count;
                wishlistButton.parentElement.appendChild(notification);
            }
        }
        
        document.addEventListener('DOMContentLoaded', function () {
            const wishlistItemCount = <%=wishlistItemCount%>;
            updateWishlistNotification(wishlistItemCount);
        });
        
    </script>

	<script type="text/javascript">
        var registrationStatus = '<%=request.getParameter("registration")%>';

        if (registrationStatus === 'success') {
            Swal.fire({
                icon: 'success',
                title: 'Registration Successful!',
                text: 'You have been successfully registered.',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'AddProfile.jsp';
                }
            });
        } else if (registrationStatus === 'failure') {
            Swal.fire({
                icon: 'error',
                title: 'Registration Failed!',
                text: 'Something went wrong. Please try again later.',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'RegistrationForm.jsp';
                }
            });
        }
    </script>
	<script>
    const clouds = document.querySelectorAll('.clouds img');
    const container1 = document.querySelector('.container1');

    container1.addEventListener('mousemove', (e) => {
      const xPos = (e.clientX / window.innerWidth) - 0.5;
      const yPos = (e.clientY / window.innerHeight) - 0.5;

      clouds.forEach(cloud => {
        const speed = cloud.getAttribute('style').split(':')[1];
        cloud.style.transform = `translate(${xPos * speed}px, ${yPos * speed}px)`;
      });
    });

    clouds.forEach(cloud => {
      cloud.addEventListener('mouseover', () => {
        cloud.style.opacity = 0;
      });
      cloud.addEventListener('mouseout', () => {
        cloud.style.opacity = 1;
      });
    });

    const text = document.querySelector('.banner h2');
    window.addEventListener('scroll', () => {
      const value = window.scrollY;
      text.style.marginBottom = `${value * 2}px`;
    });
  </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
