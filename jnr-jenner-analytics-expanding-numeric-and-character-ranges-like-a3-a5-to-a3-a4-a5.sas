Jenner Analytics expanding numeric and character ranges like a3-a5 to a3 a4 a5

Too long to post, see
https://github.com/rogerjdeangelis/jnr-jenner-analytics-expanding-numeric-and-character-ranges-like-a3-a5-to-a3-a4-a5

USAGE

NUMERIC
%put NOTE: EXPANDED RANGE = %jnr_expandrange(7-11);
NOTE: EXPANDED RANGE = 7 8 9 10 11

CHARACTER
%put NOTE: EXPANDED RANGE = %jnr_expandrange(a113-a117);
NOTE: EXPANDED RANGE = a113 a114 a115 a116 a117

/**************************************************************************************************************************/
/*  PROCESS                                                                                                                      */
/**************************************************************************************************************************/

/*--- SAVE IN YOUR AUTOCALL LIBRARY ---*/
filename ft15f001 "c:/otojnr/jnr_numlist.sas";
parmcards4;
%macro jnr_expandrange(rng);

  %if %sysfunc(indexc(%substr(&rng,1,1),0123456789)) ^= 0 %then %do;
    %let rng=%qsysfunc(translate(&rng,":","-"));
    %dosubl('
    data _null_;
       length lst $32756;
       array rng[&rng];
       do i=lbound(rng) to hbound(rng);
          rng[i]=i;
       end;
       lst=catx(" ",of rng[*]);
       call symputx("rng",lst,'G');
    run;
    ');
  %end;
  %else %do;
    %dosubl('
    data _null_;
       array rng[*] $32 &rng;
       do i= lbound(rng) to hbound(rng);
         rng[i]=vname(rng[i]);
       end;
       nams=catx(" ",of rng);
       call symputx("rng",nams,'G');
    run;
    ');
  %end;
  %trim(&rng)
%mend jnr_expandrange;
;;;;
run;

/*---  END  ---*/
