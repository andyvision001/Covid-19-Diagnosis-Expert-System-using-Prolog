% WARSAW UNIVERSITY OF TECHNOLOGY
% FACULTY OF MATHEMATICS AND INFORMATION SCIENCE
% Programming in Logic and Symbolic Programming
% IMPLEMENTATION OF PROLOG EXPERT SYSTEM (COVID-19 DIAGNOSIS)

% AUTHOR: ANDRA UMORU (324334)



% Symptoms of COVID-19
symptom(fever).
symptom(cough).
symptom(shortness_of_breath).
symptom(headache).
symptom(body_ache).
symptom(fatigue).
symptom(sore_throat).
symptom(loss_of_taste_or_smell).



% Risk factors for severe illness from COVID-19
risk_factor(age).
risk_factor(underlying_health_conditions).



% Recent Travel History
recent_travel(wuhan_china).
recent_travel(milan_italy).



% ====>
% Recursive predicate to ask about symptoms
ask_symptoms([]).
ask_symptoms([Symptom|Symptoms]) :-
  write('Do you have '),
  write(Symptom), write("? (y/n) "),
  read(Response),
  assert(symptom_response(Symptom, Response)),
  ask_symptoms(Symptoms).



% ====>
% Recursive predicate to ask about risk factors
ask_risk_factors([]).
ask_risk_factors([RiskFactor|RiskFactors]) :-
  write(RiskFactor), write("? (y/n) "),
  read(Response),
  assert(risk_factor_response(RiskFactor, Response)),
  ask_risk_factors(RiskFactors).



% ====>
% Recursive predicate ask about recent travel history
ask_recent_travels([]).
ask_recent_travels([RecentTravel|RecentTravels]) :-
  write(RecentTravel), write("? (y/n) "),
  read(Response),
  assert(recent_travel_response(RecentTravel, Response)),
  ask_recent_travels(RecentTravels).





% Predicate to suggest actions based on symptom, risk factor responses and recent travel history
suggest_actions :-
  symptom_response(fever, y), 
  symptom_response(cough, y), 
  symptom_response(shortness_of_breath, y),
  nl,
  nl,
  write("You may have COVID-19. Please self-isolate and contact your local health authorities for further guidance."), nl.

suggest_actions :-
  (recent_travel_response(wuhan_china, y),
  recent_travel_response(milan_italy, y)), 
  nl,
  nl,
  write("You might have contacted COVID-19 because of the places you visited recently. Please self-isolate for at least two weeks."), nl.

suggest_actions :-
  (symptom_response(fever, y); 
    symptom_response(cough, y)),
  risk_factor_response(age, y),
  nl,
  nl,
  write("You may be at higher risk of severe illness if you contract COVID-19. Please take extra precautions to protect yourself, such as wearing a mask and practicing physical distancing."), nl.



suggest_actions :-
  \+symptom_response(fever, y), 
  \+symptom_response(cough, y),
  \+risk_factor_response(age, y), 
  \+risk_factor_response(underlying_health_conditions, y),
  nl,
  nl,
  write("You do not appear to have any COVID-19 symptoms or risk factors. Please continue to follow recommended guidelines to prevent the spread of the virus, such as washing your hands frequently and wearing a mask in public."), nl.



% Predicate to run the expert system
run_expert_system :-
nl,write("-------------------------------------------"),
   nl,write("|  WELCOME TO COVID-19 EXPERT SYSTEM      |"),
   nl,write("|      AUTHOR: ANDRA UMORU (324334)       |"),
   nl,write("|  This is a COVID-19 diagnosis program   |"),
   nl,write("|        (it diagnose Covid-19)           |"),
   nl,write("|      Please respond by typing in        |"),
   nl,write("|                  'y/n'                  |"),
   nl,write("-------------------------------------------"),
   nl,
   nl,
  ask_symptoms([fever, cough, shortness_of_breath, headache, body_ache, fatigue, sore_throat, loss_of_taste_or_smell]),
  ask_risk_factors([age, underlying_health_conditions]),
  ask_recent_travels([wuhan_china, milan_italy]),
  suggest_actions.



% Example query to run the expert system
% ?- run_expert_system.
