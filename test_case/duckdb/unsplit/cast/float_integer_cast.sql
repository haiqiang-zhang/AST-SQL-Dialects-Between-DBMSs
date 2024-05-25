PRAGMA enable_verification;
select cast(0.5::${src} as ${dst}) as x;;
select cast(0.55::${src} as ${dst}) as x;;
select cast(1.5::${src} as ${dst}) as x;;
select cast(-0.5::${src} as ${dst}) as x;;
select cast(-0.55::${src} as ${dst}) as x;;
select cast(-1.5::${src} as ${dst}) as x;;
