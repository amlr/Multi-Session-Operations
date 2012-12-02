Options:


"Noisy decode" lists the cpp (and other 'text' files) as it is compiling them, or lint-checking them on the screen. this makes the packing that much slower.

"Striplog" removes extraneous crud from the output.log. Such items as ST errors. The full list of what's removed is in striplog.bat

"Check Externals" ensures that all rap encodable file references actually exist and also looks inside wrp and p3d's for same things. Slows packing obviously

"Ignore Proxies" Is only relevent for Check Externals, normally, this should be off, and if errors are given, check em out and turn this on if a genuine temp that the packer can't decdoe


"Clean Temp" all-bets-are-off rebuild of the item(s). The packer uncodintionalyy copies all paa no-matter what you want to do.

"Sign Pbos" uses p:\tools\keys bat files (and bikeys) to sign our pbo's

"Use Binarise" Is a quaility check that what we Rapify is better or equal to bis. It can be useful to allow bis binarise to create config.bins rather than us to 'see' what it's log looks like.






