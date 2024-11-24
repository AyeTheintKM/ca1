<%-- <%@ include file="../includes/header.jsp" %> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="../fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="../css/login-register.css">
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
						<form method="post" action="../RegisterServlet" class="register-form"
							id="register-form">
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="name" id="name" placeholder="Your Name" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="email" name="email" id="email" placeholder="Your Email" />
							</div>
							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password" placeholder="Password" />
							</div>
							<div class="form-group">
								<label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="password" name="re_password" id="re_password"
									placeholder="Repeat your password" />
							</div>
							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="text" name="phone" id="phone"
									placeholder="Contact no" />
							</div>
							<div class="form-group">
								<label for="postal_code"><i class="zmdi zmdi-home"></i></label>
								<input type="text" name="postal_code" id="postal_code"
									placeholder="Postal Code" />
							</div>
							<div class="form-group">
								<label for="unit"><i class="zmdi zmdi-home"></i></label> <input
									type="text" name="unit" id="unit" placeholder="Unit" />
							</div>
							<div class="form-group">
								<label for="floor"><i class="zmdi zmdi-home"></i></label> <input
									type="text" name="floor" id="floor" placeholder="Floor" />
							</div>
							<div class="form-group">
								<label for="block"><i class="zmdi zmdi-home"></i></label> <input
									type="text" name="block" id="block" placeholder="Block" />
							</div>
							<div class="form-group">
								<label for="street"><i class="zmdi zmdi-home"></i></label> <input
									type="text" name="street" id="street" placeholder="Street" />
							</div>

							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="../images/signup-image.jpg" alt="sing up image">
						</figure>
						<a href="login.jsp" class="signup-image-link">I am already
							member</a>
					</div>
				</div>
			</div>
		</section>


	</div>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="../js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
	var status = document.getElementById("status").value;
	if(status =="success") {
		swal("Congrats, Account Created Successfully", "success");
	}
	
</script>



</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>