/*!
 * Custom Validation for jQuery Validation Plugin
 * 
 * Developer: Himadri Ganguly
 * 
 * Developer Email:- himadri@colourdrift.com
 * 
 * Developer Website:- http://www.colourdrift.com
 * 
 */

/*!
 * jQuery Validation Plugin v1.12.0
 *
 * http://jqueryvalidation.org/
 *
 * Copyright (c) 2014 Jörn Zaefferer
 * Released under the MIT license
 */

jQuery.validator.addMethod("email", function(value, element, params) {
	return this.optional(element) || /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/.test(value);
}, jQuery.validator.format("Please enter a valid email address"));

jQuery.validator.addMethod("youtubeVideo", function(value, element) {
	return this.optional(element) || /^(https?:\/\/)?(www\.)?youtube.com\/watch\?v=([a-z0-9-]+)/i.test(value);
}, "Must be a valid Youtube Video URL");

jQuery.validator.addMethod("indian_mobile", function(value, element) {
	return this.optional(element) || /^(\(\+91\)-)([7-9]\d{4}-\d{5})$/.test(value);
}, "Not a valid Mobile Number");

jQuery.validator.addMethod("username", function(value, element) {
	return this.optional(element) || /^[a-z0-9]+$/.test(value);
}, "User must contain only lowercase letters, numbers.");