
private ["_title", "_sub_title", "_scroll", "_titlefinal", "_comment_1", "_comment_2"];

// _type = _this select 0;

// _type == 0 -> normal
// _type == 1 -> interview

// Define all the vectors containing the headlines and sub-headlines

_titles_definite_win = ["Allied success on Altis", "Allied forces control Altis", "Altis is allied", "Iranian forces in retreat", "Iranian forces defeated"];
_sub_titles_definite_win = ["The end of the fight is near, says officer", "Clear advantage has been achieved, officers report", "Situation is stabilizing, Allied command says", "Iranian presence is at minimum, Allied officers say", "Iranian forces are evacuating from Stratis"];
_comments_definite_win_1 = [
"The raging battle on Stratis may soon come to an end, as Allied troops are finally advancing, building up momentum as they move forward.",
"The operations on Stratis have been going on for the whole day, and the returning soldiers are bringing good news: the Iranians are routing.",
"Roaring of cannons, screaming of guns, rushing of helicopters. All this could shortly end here on Stratis as Iranian forces are being forced to retreat."];
_comments_definite_win_2 = [
"Driving out the Iranians from the island, the Allies are trying to push them into the sea. And they seem close to succeed.",
"Though officers are still cautious at judging the situation, many soldiers don't hide their idea that victory on the island is clear at hand.",
"As friendly casualties are more and more a rare sight and successes are continuously reported, victory seems a concrete possibility."];

_titles_moderate_win = ["Some progress made on Altis", "Fighting on Altis", "Allies marching on", "First successful operations"];
_sub_titles_moderate_win = ["Allied forces start to gain ground against Iranians", "Iranian forces still strong and dangerous, officer says", "We kicked them for good, a soldier says informally", "Iranian forces slowly retreating from their positions"];
_comments_moderate_win_1 = [
"Continuous sorties, continuous scrambling, thunder noises in the distance. Allied activity is intensifying and the situation seems to be getting increasingly better",
"Fatigued, often shocked, sometimes wounded, our soldiers come back to base after a tough mission. But the satisfaction on some of their faces is unmistakeable.",
"When another medical helicopter comes back from the front, only a few wounded get down and on their own legs. Casualties are not as bad as before."];
_comments_moderate_win_2 = [
"With the last successes on the ground, the Allied forces are finally getting the upper hand in the conflict. As the fight continues, optimism is finally allowed.",
"Finally getting a tangible advantage, Allied forces rush forward in the attempt to unbalance the invading Iranian forces. And there is a possibility that this is the chance they were waiting for.",
"The Allied operations are finally producing some tangible successes and the commanders do not want to have this chance slipping away. The next hours will be decisive and could decide the winner of this battle."];

_titles_slight_win = ["Allied forces push forward", "Allied attacks intensify", "Iranians on the defensive", "Altis: a winnable battle?", "Timid progress on Altis", "An inch more every day"];
_sub_titles_slight_win = ["Only few casualties during recent operations, officer reports", "Iranians are holding their lines, but abandoning some forward positions", "Allies achieve some little but vital success in recent operations", "Iranian resistance is still fierce but defeatable, officer says", "Logistics is at full speed to sustain the effort, officer reports", "Our strategy is starting to pay off, command says", "New reinforcements imminent, an informer says"];
_comments_slight_win_1 = [
"Intense fighting days here on Altis. Major operations have been underway for the whole week and the situation has been uncertain and, as they say, fluid.",
"As the Allies decided to show their muscles, Iranians seem to have become hesitant. Some soldiers report they have seen them abandoning their forwardmost positions.",
"No place is silent on Altis. Noises of the ongoing battle are enveloping the entire territory with no exceptions."];
_comments_slight_win_2 = [
"First timid successes are finally concretizing for the Allied forces, bringing much needed optimism and raising the morale anough to carry on fighting for another day.",
"Inch by inch, Allies are making their way through the island, facing the fierce Iranian resistance. However, Allied forces have managed to build a small advantage, which may become larger in the future.",
"The constant aggressive tactics used by the Allies seem to be finally paying off, bringing some early, shallow successes. If these successes will be long lasting, only time will tell."];

_titles_balanced = ["The infinite war", "Intense fights on Altis", "Still a battleground", "Any hope for Altis?", "The fight drags on"];
_sub_titles_balanced = ["Intense fights during the whole week as hostilities escalate", "New reinforcements just arrived. Will they change the course of the fight?", "This is a strategic theater and we are goind our best, commander says", "Iranian forces are trained and well equipped, an officer says", "Considerable casualties on both sides as the fight drags on", "The fight drags on without any definite winner or loser"];
_comments_balanced_1 = [
"The fight rages on the Greek Island of Altis. Both sides are struggling to get an advantage over their counterpart. However, the situation still seems perfectly balanced.",
"As the conflict proceeds, Allied forces are trying to study their enemy in order to achieve an advantage over them. On the opposite side, Iranians do the same.",
"Allies on the West, Iranians on the East of Altis island. The two sides study each other, taunt each other, clash against each other. However, no winner has yet emerged."];
_comments_balanced_2 = [
"The conflict is probably destined to last as neither side wants to leave an advantage to its enemy. While the two formations clash, casualties continue to mount up.",
"Crackling gunshots and roaring explosions are heard on the whole island, leading to no tangible advantage for neither side. The conflict drags on: for how much time, nobody can tell.",
"The fighting leaves plenty of bodies on the ground, but leads to no decisive event. Victory is still far and neither side wants to leave it to their enemy."];

_titles_slight_lose = ["Allied forces pull back", "Iranian attacks intensify", "Allied on the defensive", "Altis: an announced defeat?", "No progress on Altis"];
_sub_titles_slight_lose = ["High casualties on yesterday operation", "Iranian reinforcements put Allies in difficulty", "Our lines are not as secure as they look, a soldier says informally", "Some informers suggest an equipment shortage, but command denies", "We are still holding our ground, officer says", "We will take necessary actions to ensure safety, command says"];
_comments_slight_lose_1 = [
"As the conflict proceeds, it is becoming clear that Iranian troops are better trained and equipped than expected. Their actions are precise and their capabilities seem quite vast.",
"The fight on Altis continues and Allied forces seem to show slight difficulties maintaining some of their defensive positions and outposts.",
"As Iranian operations are intensifying, Allied forces are beginning to suffer more casualties than usual. Medical helicopters have been continuously on the run in the previous hours."];
_comments_slight_lose_2 = [
"Iranian forces keep pushing forward, while the Allies seem having difficulties holding their ground. However, officers seem confident that the next operations will have different outcome.",
"Allies are trying to seize again the initiative, but Iranian forces are slowly building up momentum. The next hours will probably be decisive to define the final outcome of this battle.",
"Allied forces are entirely deployed and constantly working ad full capability to ensure safety and try to stop the advancing enemy."];

_titles_moderate_lose = ["Casualties still high", "Iranian forces advancing", "Allied forces in difficulty", "Altis defence thinning"];
_sub_titles_moderate_lose = ["We lack proper supplies, an anonymous informer says", "Casualties are beginning to pile up on Altis", "There have been mistakes on our side, a soldier says informally", "Troops morale starts to appear low"];
_comments_moderate_lose_1 = [
"The fight on Altis continues, and it is not turning for good for the Allied forces. Recent operations have brought no progress, while Iranian forces are still dangerously advancing.",
"Allied forces have suffered an increasing number of casualties lately, as Iranian tactical situation seems to be emerging as superior. Some soldiers are starting to express some worry.",
"Iranian forces are determined, strong and well equipped. Allies have long acknowledged these facts, but still have not found adequate countermeasures."];
_comments_moderate_lose_2 = [
"With Iranian forces still advancing, the Allied position is becoming more and more complicated. However, the Allied command seems confident that this is only a temporary situation.",
"The Iranian advance is hard to stop. Allied commanders and soldiers are trying their best, but it does not seem enough. The next hours may be crucial for the entire battle here on Altis.",
"Allied forces are trying to regain their balance, but the enemy strength is still very high"];

_titles_definite_lose = ["Out of Altis soon", "Defeat imminent", "Allied forces prepare retreat", "Altis is untenable", "Last resistance on Altis"];
_sub_titles_definite_lose = ["Evacuation of key personnel has already begun", "Altis island is declared untenable by Allied command", "Casualties are being evacuated, but are still piling up", ""];
_comments_definite_lose_1 = [
"Killed in action, missed in action, mortally wounded. These are the most frequent reports here on Altis for the Allied forces. Morale is low and numbers are thinning.",
"Medevac helicopters running constantly, fresh supplies of blood and plasma running into the base. This is the battle as seen from Altis Air Base.",
"Crackling gunshots are getting closer to the Air Base today, and a sergeant advises us to stay in cover, for you do not know when a mortar shell could come in."];
_comments_definite_lose_2 = [
"While the Allied command is not releasing any comment, it is clear that a retreat is already being organized. However, Allies will maybe try a last action before leaving the island to the Iranians.",
"Some of the vital supplies and equipment seem to have been already been evacuated from the base, even if officers deny this fact. The situation looks grim, and the soldiers could soon follow that equipment.",
"The wounded have already been evacuated from the Allied base, leaving only the personnel that is still capable of fighting. These brave soldiers will probably try a last stand before following their comrades."];

/* _titles_civ_like = ["", ""];
_sub_titles_civ_like = [];

_titles_civ_dislike = [];
_sub_titles_civ_dislike = [];

_titles_civ_happy = [];
_sub_titles_civ_happy = [];

_titles_civ_unhappy = [];
_sub_titles_civ_happy = []; */



// Now, based on campaign status, we choose the news

if ((campaign_balance >= 0.15) and (campaign_balance < 0.3)) then
{
	_title = _titles_slight_win call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_slight_win call BIS_fnc_selectRandom;
	_comment_1 = _comments_slight_win_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_slight_win_2 call BIS_fnc_selectRandom;
};
if ((campaign_balance >= 0.3) and (campaign_balance < 0.75)) then
{
	_title = _titles_moderate_win call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_moderate_win call BIS_fnc_selectRandom;
	_comment_1 = _comments_moderate_win_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_moderate_win_2 call BIS_fnc_selectRandom;
};
if (campaign_balance >= 0.75) then
{
	_title = _titles_definite_win call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_definite_win call BIS_fnc_selectRandom;
	_comment_1 = _comments_definite_win_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_definite_win_2 call BIS_fnc_selectRandom;
};
if ((campaign_balance <= -0.15) and (campaign_balance > -0.3)) then
{
	_title = _titles_slight_lose call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_slight_lose call BIS_fnc_selectRandom;
	_comment_1 = _comments_slight_lose_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_slight_lose_2 call BIS_fnc_selectRandom;
};
if ((campaign_balance <= -0.3) and (campaign_balance > -0.75)) then
{
	_title = _titles_moderate_lose call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_moderate_lose call BIS_fnc_selectRandom;
	_comment_1 = _comments_moderate_lose_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_moderate_lose_2 call BIS_fnc_selectRandom;
};
if (campaign_balance <= -0.75) then
{
	_title = _titles_definite_lose call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_definite_lose call BIS_fnc_selectRandom;
	_comment_1 = _comments_definite_lose_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_definite_lose_2 call BIS_fnc_selectRandom;
};
if ((campaign_balance > -0.15) and (campaign_balance < 0.15)) then
{
	_title = _titles_balanced call BIS_fnc_selectRandom;
	_sub_title = _sub_titles_balanced call BIS_fnc_selectRandom;
	_comment_1 = _comments_balanced_1 call BIS_fnc_selectRandom;
	_comment_2 = _comments_balanced_2 call BIS_fnc_selectRandom;
};

// We put together the headlines to form the main message!

_titlefinal = parsetext format ["<t size='2'>%1</t><br/>%2", _title, _sub_title];


// Time to think about the scroll, with many many short news

_scroll_news_1 = [
"Greek president is in a safe but secret location, Allies report",
"Water shortage on Altis, population in danger",
"The fight continues on Altis, situation still fluid",
"Allied command on Altis reports success in recent operation",
"Negotiations at a halt, as Iran withdrew embassadors",
"Negotiations are impossible, USA president says",
"Nuclear attack is not an option, USA president says",
"Activists demonstrate for peace in New York",
"Anonymous attack on Iran net uncovers was crimes",
"Humanitarian emergency in Greece cannot wait, UN spokesman says"];

_scroll_news_2 = [
"Raw oil hits new high over 300 dollars",
"Stock Exchange quotations rise after reported successes on Altis",
"Green Economy won't save us, expert says. Debate rises",
"We need to change economy paradigm or war will be endless, Nobel laureate says",
"USA GDP rises by 3 percent, but public debt reaches historical max",
"EU GDP is stagnating for 30th year in a row",
"EU economic crisis is almost over, EU president says",
"Greek economy will be sustained by humanitarian aid, UN spokesman says",
"German production is at historical maximum, due to war efforts",
"Public debts rising in all Allied countries, but authorities minimize problem"];

_scroll_news_3 = [
"New prosthetic technology from US Army will save lives, health minister says",
"Popstar Lady BlahBlah sings naked at Pope's birthday celebration",
"Famous actor admits drugs addiction",
"Dark matter finally observed. Scientific milestone reached, researchers say",
"NASA-ESA space programs cancelled due to war efforts",
"Chinese Space Station Tiangong 5 is now twice as big as ISS",
"Stem cells manipulation has reached its full capabilities, researchers say",
"Blood donation campaign begins to support troops",
"New brain functionalities uncovered in recent study",
"Intel releases first full quantum computer for civilian uses"];

_scroll_selected_1 = _scroll_news_1 call BIS_fnc_selectRandom;
_scroll_selected_2 = _scroll_news_2 call BIS_fnc_selectRandom;
_scroll_selected_3 = _scroll_news_3 call BIS_fnc_selectRandom;

_scrollfinal = parsetext format ["%1 - %2 - %3", _scroll_selected_1, _scroll_selected_2, _scroll_selected_3];


// BIS_fnc_AAN is a bit crappy, so I made another one where it uses layer 3000 to show the news
// In this way, you can delete it easily when the scene ends!

// nul = [_titlefinal, _scrollfinal] spawn BIS_fnc_AAN;
nul = [_titlefinal, _scrollfinal] spawn raven_news_init;
sleep 2;
titleText [_comment_1, "PLAIN DOWN"];
sleep 14;
titleText [_comment_2, "PLAIN DOWN"];
sleep 12;
titleText ["", "PLAIN DOWN"];
