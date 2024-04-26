--

call mtr.add_suppression("Invalid .* username when attempting to connect to the source server");

-- Clean up
RESET SLAVE ALL;
