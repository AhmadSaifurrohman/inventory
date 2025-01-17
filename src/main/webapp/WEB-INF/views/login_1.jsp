
<!doctype html>
<html lang="en">
	<head>
		<title>Login Inventory</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<link rel="stylesheet" href="https://preview.colorlib.com/theme/bootstrap/login-form-18/css/style.css">

		<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>

		<style>
			.login-wrap .icon {
				background: #b7b0b0;
			}
			.login-wrap h3 {
				color: #b7b0b0;
			}

			.circle-img {
				width: 125px;
				height: 125px;
				border-radius: 50%;
				object-fit: cover;
				border: 2px solid white;
				background-color: white;
			}

			body {
				background-image: url('/static/image/turangga-slide-2098642433.jpg');
				background-size: cover;
				background-repeat: no-repeat;
				background-position: center;
				background-attachment: fixed;
			}

		</style>
	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section" style=" color: white; ">Welcome !</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-5">
					<div class="login-wrap p-4 p-md-5" style="
						background-color: #bec0c5;
						opacity: 90%;
					">
		      			<div class="icon d-flex align-items-center justify-content-center">
							<span class="image_logo">
								<!-- width="500" height="600" -->
								<img src="/static/image/turangga-logo-181372112.png" alt="logo" class="circle-img">
							</span>
						</div>
						<h3 class="text-center mb-4" style=" margin-top: 15%; color: white;">INVENTORY MANAGEMENT SYSTEM</h3>
						<form action="/login/auth" method="POST" id="loginForm" class="login-form">
							<input type="hidden" name="csrfToken" value="${csrfToken}" />
							<div class="form-group">
								<p class="text-left mb-2" style=" color: white; ">Username</p>
									<input type="text" class="form-control rounded-left" name="username" id="username" placeholder="Username"  style="color: black;">
								<p class="text-left mt-2" style=" color: white; ">Password</p>
							</div>
							<div class="form-group d-flex">
								<input type="password" class="form-control rounded-left" id="password" placeholder="Password" style="color: black;" required>
								<input type="hidden" id="hashedPassword" name="password" />
							</div>
							<div class="form-group d-md-flex">
								<div class="w-50">
									<label class="checkbox-wrap checkbox-secondary" style="color: white">Remember Me
										<input type="checkbox" checked>
										<span class="checkmark"></span>
									</label>
								</div>
								<div class="w-50 text-md-right">
									<a href="#" style="color: white;">Forgot Password</a>
								</div>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-secondary rounded submit p-3 px-5" >Login</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
		document.getElementById("loginForm").addEventListener("submit", function (e) {
			e.preventDefault();
			const rawPassword = document.getElementById("password").value;
			const hashedPassword = CryptoJS.SHA256(rawPassword).toString();
			document.getElementById("hashedPassword").value = hashedPassword;
			this.submit();
		});
	</script>

	<script src="https://preview.colorlib.com/theme/bootstrap/login-form-18/js/jquery.min.js"></script>
	<script src="https://preview.colorlib.com/theme/bootstrap/login-form-18/js/popper.js"></script>
	<script src="https://preview.colorlib.com/theme/bootstrap/login-form-18/js/bootstrap.min.js"></script>
  	<script src="https://preview.colorlib.com/theme/bootstrap/login-form-18/js/main.js"></script>

    <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"8f85d5716c503e25","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"version":"2024.10.5","token":"cd0b4b3a733644fc843ef0b185f98241"}' crossorigin="anonymous"></script>
</body>
</html>

