<%-- 
    Document   : test
    Created on : May 11, 2018, 1:53:45 PM
    Author     : Sheha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dydox.lk</title>

        <link rel="stylesheet" href="css/tabs.css" >
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="js/imageZoom.js"></script>
        <link rel="stylesheet" href="css/imageZoom.css" >


        <link rel="stylesheet" href="css/home_style.css" >
        <link rel="stylesheet" href="css/notification.css" >

        <style type="text/css">
            .upload-button {
                padding: 4px;
                border: 1px solid black;
                border-radius: 5px;
                display: block;
                float: left;
            }

            .profile-pic {
                max-width: 200px;
                max-height: 200px;
                display: block;
            }

            .file-upload {
                display: none;
            }
        </style>


    </head>

    <body>
    <center>

        <img class="profile-pic" src="images/avatar_pro.png" />
        <div class="upload-button">Upload Image</div>
        <input class="file-upload" type="file" accept="image/*"/>
    </center>
    <script type="text/javascript">
        $(document).ready(function() {


            var readURL = function(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function(e) {
                        $('.profile-pic').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }


            $(".file-upload").on('change', function() {
                readURL(this);
            });

            $(".upload-button").on('click', function() {
                $(".file-upload").click();
            });
        });
    </script>

</body>
</html>
