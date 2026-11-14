'use strict';

// The requested account is fixed, with no login, remote profile, or editable identity.
const ACCOUNT = Object.freeze({name:'Rurik Hagman', email:'rurik.hagman@gmail.com', personNumber:'0105013338', initials:'RH'});
const D = window.STUK_DATA;
const groupNames = ['hotDeals','popular','newDeals','tvStreaming','mobile','fashion','health','sport','jewelry','extras'];
const allDeals = groupNames.flatMap(group => D[group].map((deal, index) => Object.assign(deal, {id:`${group}-${index}`})));
D.events.forEach((event, index) => event.id = index);
const screen = document.getElementById('screen');
const tabs = document.getElementById('tabs');
const overlay = document.getElementById('overlay');
let route = {name:'home'}, routeStack = [], modal = null, cardIndex = 1, cardFlipped = false;
let calendarTab = 0, selectedDay = 16, sortChoice = 0, eventDate = 0;
let animationHandles = [], loadingTimer = null, toastTimer = null;
const favorites = new Set(JSON.parse(localStorage.getItem('favorites') || '[]'));

const paths = {
  home:'<path fill="currentColor" stroke="none" d="M2 10.5 12 2l10 8.5-1.8 2.1L19 11.5V22h-5v-7h-4v7H5V11.5l-1.2 1.1z"/>',
  calendar:'<rect x="3" y="5" width="18" height="17" rx="2"/><path d="M3 10h18M8 2v6M16 2v6"/><path d="M7 14h1m4 0h1m4 0h1M7 18h1m4 0h1m4 0h1"/>',
  card:'<path d="M5 3h14M3 6h18"/><rect x="2" y="9" width="20" height="13" rx="2" fill="currentColor" stroke="none"/>',
  tickets:'<path fill="currentColor" stroke="none" d="M2 5h20v5a2 2 0 0 0 0 4v5H2v-5a2 2 0 0 0 0-4z"/><path d="M16 7v2m0 2v2m0 2v2" stroke="#000"/>',
  profile:'<circle cx="12" cy="12" r="10" fill="currentColor" stroke="none"/><circle cx="12" cy="9" r="3.1" fill="#000" stroke="none"/><path d="M5 19c.5-7 13.5-7 14 0" fill="#000" stroke="none"/>',
  menu:'<path d="M3 6h18M3 12h18M3 18h18"/>',
  search:'<circle cx="10" cy="10" r="7"/><path d="m15 15 6 6"/>',
  pin:'<path d="M19 9c0 5-7 12-7 12S5 14 5 9a7 7 0 1 1 14 0Z"/><circle cx="12" cy="9" r="2"/>',
  back:'<path d="m15 3-9 9 9 9"/>', right:'<path d="m9 4 8 8-8 8"/>',
  close:'<path d="m5 5 14 14M19 5 5 19"/>',
  heart:'<path d="M20.8 4.6c-2.5-2.5-6.5-1.3-8.8 1-2.3-2.3-6.3-3.5-8.8-1C-2 10 9 18.7 12 21c3-2.3 14-11 8.8-16.4Z"/>',
  share:'<path d="M7 8H4v14h16V8h-3M12 15V2m-4 4 4-4 4 4"/>',
  filter:'<path d="M3 5h18M6 12h12M9 19h6"/>',
  sliders:'<path d="M3 5h18M3 12h18M3 19h18"/><circle cx="8" cy="5" r="2" fill="#222"/><circle cx="16" cy="12" r="2" fill="#222"/><circle cx="10" cy="19" r="2" fill="#222"/>',
  edit:'<path d="M13 4H3v17h17V11M8 16l1-5L19 1l4 4-10 10z"/>',
  gear:'<path d="m10 2-1 3-3 1-3-1-2 4 3 2v3l-2 2 2 4 3-1 3 1 1 3h4l1-3 3-1 3 1 2-4-3-2v-3l2-2-2-4-3 1-3-1-1-3z" transform="translate(0 -1) scale(.92)"/><circle cx="12" cy="12" r="3"/>',
  document:'<path d="M5 2h10l5 5v15H5zM14 2v6h6M8 12h9M8 16h9"/>',
  privacy:'<circle cx="12" cy="12" r="9" stroke-dasharray="3 3"/>',
  mail:'<rect x="2" y="4" width="20" height="16" rx="2"/><path d="m2 5 10 8L22 5"/>',
  external:'<path d="M13 3h8v8M21 3 10 14M9 3H3v18h18v-6"/>',
  check:'<circle cx="12" cy="12" r="10" fill="currentColor" stroke="none"/><path d="m7 12 3 3 7-7" stroke="#000"/>',
  person:'<circle cx="12" cy="6" r="4"/><path d="M4 22v-2c0-10 16-10 16 0v2"/>',
  book:'<path d="M12 5c-3-3-7-3-10-2v17c4-2 7-1 10 1 3-2 6-3 10-1V3c-3-1-7-1-10 2Zm0 0v16"/>',
  phone:'<rect x="6" y="1" width="12" height="22" rx="2"/><path d="M10 19h4"/>',
  shirt:'<path d="m8 2 4 3 4-3 7 5-4 5-2-1v12H7V11l-2 1-4-5z"/>',
  scissors:'<circle cx="5" cy="5" r="3"/><circle cx="5" cy="19" r="3"/><path d="m7 7 14 14M7 17 21 3"/>',
  plane:'<path d="m12 2 2 8 8 5v2l-8-2v5l3 2H7l3-2v-5l-8 2v-2l8-5z"/>',
  tv:'<rect x="1" y="3" width="22" height="16" rx="2"/><path d="M8 23h8M12 19v4M9 7l7 4-7 4z"/>',
  diamond:'<path d="m1 8 5-6h12l5 6-11 15zM1 8h22M6 2l6 21 6-21"/>',
  ball:'<circle cx="12" cy="12" r="10"/><path d="m12 7 5 4-2 6H9l-2-6zM12 7V2M7 11l-5-2m20 0-5 2M9 17l-3 4m9-4 3 4"/>',
  health:'<rect x="2" y="6" width="20" height="16" rx="3"/><path d="M8 6V2h8v4M12 10v8M8 14h8"/>',
  box:'<path d="m2 6 10-5 10 5v13l-10 4-10-4Zm0 0 10 5 10-5M12 11v12M7 3l10 5"/>',
  food:'<path d="M4 2v8m3-8v8m3-8v8M4 7h6M7 10v12M19 22V2c-7 4-7 12 0 12"/>',
  bank:'<rect x="1" y="5" width="22" height="14" rx="2"/><circle cx="12" cy="12" r="4"/><path d="M4 9v6m16-6v6"/>',
  laptop:'<rect x="4" y="2" width="16" height="15" rx="1"/><path d="m4 17-3 4h22l-3-4"/>',
  party:'<path d="m3 21 4-14 10 10zM8 4V1m6 7 4-5m0 9 5-2M11 2l2 2m7 12 3 2"/>',
  map:'<path d="m2 5 7-3 6 3 7-3v18l-7 3-6-3-7 3Zm7-3v18m6-15v18"/>',
  leaf:'<path fill="currentColor" stroke="none" d="M21 2C7 0-1 9 6 16c6 7 16-1 15-14Z"/><path d="M3 22 18 6"/>',
};
function icon(name, extra='') { return `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" ${extra}>${paths[name] || paths.box}</svg>`; }
function esc(value) { return String(value ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c])); }
function action(name, value='') { return `data-action="${name}" data-value="${esc(value)}"`; }
function round(name, label, command, value='') { return `<button class="round" aria-label="${esc(label)}" ${action(command,value)}>${icon(name)}</button>`; }
function picture(item, cls='', label='', showFallback=true) {
  const available = item.imageAvailable !== false;
  return `<div class="photo ${cls} ${available?'':'failed'}" style="--accent:${esc(item.accentColor || item.bgColor || '#212121')}">${available?`<img src="${esc(item.image)}" alt="${esc(label || item.brand || item.title || '')}">`:''}${showFallback?`<span class="fallback">${esc(item.displayName || item.brand || item.title || label).toUpperCase()}</span>`:''}</div>`;
}
function labelledPicture(item, cls='', label='', showFallback=true) {
  const base = picture(item,cls,label,showFallback);
  return base.slice(0,-6) + `<span class="photo-label">${esc(label || item.brand)}</span></div>`;
}
function header(title, left='menu', right='search', leftAction='menu', rightAction='search') {
  return `<header class="header">${round(left,left==='back'?'Tillbaka':'Meny',leftAction)}<h1>${esc(title)}</h1>${right?round(right,right==='search'?'Sök':'Alternativ',rightAction):'<span></span>'}</header>`;
}
function dealCard(deal) {
  let photo = labelledPicture(deal,'',deal.brand.toUpperCase(),false);
  if (deal.isCampaign) photo = photo.slice(0,-6) + '<span class="campaign">KAMPANJ</span></div>';
  return `<button class="deal" ${action('deal',deal.id)}>${photo}<div class="deal-title">${esc(deal.title)}</div></button>`;
}
function section(title, deals, category='', emoji='', isNew=false) {
  return `<section class="section"><div class="section-head"><h2>${esc(title)} ${emoji} ${isNew?'<span class="new">NEW</span>':''}</h2><button ${action('list',category)}>Visa alla</button></div><div class="rail">${deals.map(dealCard).join('')}</div></section>`;
}
function renderTabs(current) {
  tabs.className = current==='card'?'hidden':'tabs';
  tabs.innerHTML = [['home','Hem'],['calendar','Evenemang'],['card','Kort'],['tickets','Kuponger'],['profile','Profil']].map(([name,label]) => `<button class="tab ${current===name?'active':''}" aria-label="${label}" ${current===name?'aria-current="page"':''} ${action('tab',name)}><span class="tab-inner">${icon(name)}</span>${name==='tickets'?'<span class="badge">1</span>':''}</button>`).join('');
}
function home() {
  const heroes = D.popular.slice(0,2);
  return `<div class="hero-carousel">${heroes.map(deal => `<article class="hero" ${action('deal',deal.id)}>${picture(deal)}<div class="hero-copy"><h1>${icon('leaf')} ${esc(deal.brand)}</h1><p>${esc(deal.title)}</p><button class="cta" style="--button:${deal.buttonColor}" ${action('deal',deal.id)}>Till erbjudandet</button></div></article>`).join('')}</div><div class="float-top">${round('menu','Kategorier','menu')}${round('pin','I närheten','nearby')}</div><div class="dots"><span class="dot selected"></span><span class="dot"></span></div><div class="search"><input id="home-search" aria-label="Sök rabatter" placeholder="Vad letar du efter?">${icon('search')}</div>${section('Hot deals',D.hotDeals,'','🔥')}${section('Populära rabatter',D.popular,'','🛍')}${section('Nya studentrabatter',D.newDeals,'','',true)}${[['TV & Streaming','tvStreaming','📺'],['Mobil & Bredband','mobile',''],['Kläder & Mode','fashion',''],['Hälsa & Apotek','health',''],['Sport & Träning','sport',''],['Smycken & Accessoarer','jewelry','']].map(([title,key,emoji]) => section(title,D[key],title,emoji)).join('')}`;
}
function calendar() {
  return header('Evenemang','calendar','filter','calendar-modal','sort') + `<div class="pills"><button class="pill ${calendarTab===0?'selected':''}" ${action('calendar-tab',0)}>Evenemang</button><button class="pill ${calendarTab===1?'selected':''}" ${action('calendar-tab',1)}>Utforska</button><button class="pill" ${action('sort')}>Filter ${icon('sliders')}</button><button class="pill">Lund</button></div><div class="events">${D.events.map(event => `<button class="event" ${action('event',event.id)}>${labelledPicture(event,'',event.title)}<div class="event-info"><p>${esc(event.nation)}</p><h3>${esc(event.title)}</h3></div><div class="event-date">${icon('calendar')}${esc(event.date)}</div></button>`).join('')}</div>`;
}
function tickets() {
  return header('Kuponger') + `<div class="grid coupon-grid">${D.coupons.map((coupon,index) => `<button class="coupon" ${action('coupon',index)}><div class="coupon-image" style="--accent:${coupon.bgColor}">${picture(coupon)}</div><div class="coupon-copy"><div class="coupon-brand">${esc(coupon.brand)}</div><div class="coupon-title">${esc(coupon.title)}</div><div class="coupon-valid">${esc(coupon.validUntil)}</div></div></button>`).join('')}</div>`;
}
function row(name, label, command='noop', value='', external=false) {
  return `<button class="row" ${action(command,value)}>${icon(name)}<span>${esc(label)}</span>${icon(external?'external':'right','class="end"')}</button>`;
}
function profile() {
  return header('Profil') + `<div class="profile"><div class="group"><div class="user"><h2>${ACCOUNT.name}</h2><p>${ACCOUNT.email}</p></div>${row('edit','Redigera profil')}${row('tickets','Mina biljetter')}${row('heart','Mina rabatter')}</div><div class="group">${row('gear','Inställningar','settings')}${row('document','Allmänna villkor','noop','',true)}${row('privacy','Integritetspolicy','noop','',true)}${row('mail','Medlemsservice')}</div><button class="logout">Logga ut</button></div>`;
}
function settings() {
  return header('Inställningar','back',null,'back') + `<div class="settings"><label for="fixed-name">Namn</label><input id="fixed-name" readonly value="${ACCOUNT.name}"><label for="fixed-email">E-post</label><input id="fixed-email" readonly value="${ACCOUNT.email}"><label for="fixed-person">Personnummer</label><input id="fixed-person" readonly value="${ACCOUNT.personNumber}"></div>`;
}
function list() {
  let deals = route.category ? allDeals.filter(deal => deal.category === route.category) : [...D.hotDeals,...D.popular,...D.newDeals];
  if (route.query) deals = allDeals.filter(deal => `${deal.brand} ${deal.title} ${deal.category}`.toLocaleLowerCase('sv').includes(route.query.toLocaleLowerCase('sv')));
  if (!deals.length && !route.query) deals = allDeals.slice(0,8);
  return header(route.query ? 'Sökresultat' : route.category || 'Hot deals 🔥','back',null,'back') + (route.query?`<div class="search"><input id="list-search" value="${esc(route.query)}" aria-label="Sök rabatter">${icon('search')}</div>`:'') + (deals.length?`<div class="grid">${deals.map(dealCard).join('')}</div>`:'<p class="empty">Inga rabatter hittades.</p>');
}
function dealDetail() {
  const deal = allDeals.find(item => item.id === route.id);
  const similar = allDeals.filter(item => item.category===deal.category && item.id!==deal.id).slice(0,4);
  return labelledPicture(deal,'detail-hero',deal.brand.toUpperCase(),false) + `<div class="float-top">${round('back','Tillbaka','back')}<div class="actions"><button class="round" id="favorite" aria-label="Spara rabatt" aria-pressed="${favorites.has(deal.id)}" ${action('favorite',deal.id)}>${icon('heart',favorites.has(deal.id)?'fill="currentColor"':'')}</button>${round('share','Dela','noop')}</div></div><h1 class="detail-title">${esc(deal.title)}</h1><p class="detail-description">${esc(deal.description)}</p><div class="cta-wrap"><button class="cta" style="--button:${deal.buttonColor}">Till erbjudandet</button></div><div class="detail-benefits"><div>${icon('check')}Fri frakt inom Sverige</div><div>${icon('check')}Fria returer</div></div><h2 class="detail-heading">${esc(deal.brand)}: ${esc(deal.title)}</h2><h2 class="detail-heading">Liknande rabatter</h2><div class="grid">${similar.map(dealCard).join('')}</div><div class="terms"><h2>Villkor</h2><p>${esc(deal.terms)}</p></div>`;
}
function eventDetail() {
  const event = D.events[route.id];
  return labelledPicture(event,'event-detail-hero',event.title.toUpperCase()) + `<div class="float-top">${round('back','Tillbaka','back')}${round('share','Dela','noop')}</div><h1 class="event-detail-title">${esc(event.title)}</h1><div class="event-details"><div>${icon('calendar')}<span>${esc(event.date)}</span></div><div>${icon('pin')}<span>${esc(event.nation)}<br><span class="muted">${esc(event.nationAddress)}</span></span></div><div>${icon('person')}<span>${esc(event.nation)}</span></div></div><div class="rail date-options">${event.upcomingDates.map(([day,time],index) => `<button class="date-option ${index===eventDate?'selected':''}" ${action('event-date',index)}><strong>${esc(day)}</strong><span>${esc(time)}</span></button>`).join('')}</div><p class="event-description">${esc(event.description)}</p>`;
}
function nearby() {
  return header('I närheten','back','map','back','noop') + `<div class="rail cities">${D.cities.map((city,index) => `<button ${action('city',index)}>${labelledPicture(city,'city',city.name)}</button>`).join('')}</div><button class="photo nearby-promo" ${action('deal',D.popular.find(deal=>deal.brand==='hallon')?.id || D.hotDeals[0].id)}>${D.nearbyPromo.imageAvailable?`<img src="${D.nearbyPromo.image}" alt="Pressbyrån">`:`<span class="fallback" style="display:flex;background:#a6bfd9">PRESSBYRÅN</span>`}<span class="photo-label">Studentkaffe från 10 kr</span></button>${section('Café & Restaurang',[...D.health,...D.popular])}${section('Kläder & Mode',D.fashion,'Kläder & Mode')}`;
}
function city() { return header(D.cities[route.id].name,'back',null,'back') + `<div class="grid">${[...D.hotDeals.slice(0,8),...D.popular.slice(0,4)].map(dealCard).join('')}</div>`; }

function card() {
  const fronts = ['malmocard','nationcard_back','studentlundcard_back'];
  const backs = ['malmocard_back','nationcard','studentlundcard'];
  return `<div class="moving-background">${Array.from({length:10},(_,i)=>`<img class="floating-logo" src="${D.assets.stuk_logo2}" alt="" data-logo="${i}">`).join('')}</div><div class="card-stage" role="button" tabindex="0" aria-label="Vänd kort ${cardIndex}" ${action('flip')}><div class="card-rotator ${cardFlipped?'flipped':''}"><div class="card-face front"><img src="${D.assets[fronts[cardIndex-1]]}" alt="Kort ${cardIndex}, framsida"></div><div class="card-face back"><img src="${D.assets[backs[cardIndex-1]]}" alt="Kort ${cardIndex}, baksida">${cardIndex===3?'<div class="card-cover"></div>':''}<div class="card-person ${['malmo','nation','studentlund'][cardIndex-1]}"><div>${ACCOUNT.name}</div><div class="person-number">${ACCOUNT.personNumber}</div>${cardIndex===1?'<div class="validity">GILTIGT TILL: 2025-08-31</div>':''}</div></div></div></div><div class="card-controls"><button class="card-close" ${action('close-card')}>Stäng</button>${[1,2,3].map(index=>`<button class="card-select ${index===cardIndex?'selected':''}" aria-label="Visa kort ${index}" aria-pressed="${index===cardIndex}" ${action('card-select',index)}>${index}</button>`).join('')}<button class="card-qr" aria-label="Visa QR-kod" ${action('qr')}><img src="${D.assets.qr}" alt=""></button><button class="card-refresh" aria-label="Uppdatera kort" ${action('refresh')}><img src="${D.assets.refresh}" alt=""></button></div>`;
}
function startCardAnimation() {
  const width = screen.clientWidth, height = screen.clientHeight;
  document.querySelectorAll('.floating-logo').forEach((logo,index) => {
    const x = (index*79+28) % width, y = (index*139+42) % height;
    const frames = Array.from({length:5},(_,i)=>({transform:`translate(${i===0?x:(index*113+i*131) % width}px,${i===0?y:(index*173+i*197) % height}px)`}));
    animationHandles.push(logo.animate(frames,{duration:32000+index*3000,iterations:Infinity,direction:'alternate',easing:'linear'}));
  });
  const stage = document.querySelector('.card-stage');
  let startX = 0, startY = 0, swiped = false;
  stage.addEventListener('pointerdown',event=>{startX=event.clientX;startY=event.clientY;swiped=false;});
  stage.addEventListener('pointerup',event=>{
    const dx = event.clientX-startX;
    if (Math.abs(dx)>50 && Math.abs(dx)>Math.abs(event.clientY-startY)) {
      swiped=true;event.preventDefault();
      cardIndex=Math.max(1,Math.min(3,cardIndex+(dx<0?1:-1)));
      render();
    }
  });
  stage.addEventListener('click',event=>{if(swiped){event.stopImmediatePropagation();swiped=false;}});
  stage.addEventListener('keydown',event=>{if(event.key==='Enter'||event.key===' '){event.preventDefault();handle('flip');}});
}
function render(keepScroll=false) {
  const previousScroll=screen.scrollTop;
  animationHandles.forEach(handle=>handle.cancel());animationHandles=[];
  screen.className=route.name==='card'?'card-screen':'';
  const renderers={home,calendar,tickets,profile,settings,list,deal:dealDetail,event:eventDetail,nearby,city,card};
  screen.innerHTML=renderers[route.name]();
  renderTabs(route.name==='card'?'card':['calendar','event'].includes(route.name)?'calendar':route.name==='tickets'?'tickets':['profile','settings'].includes(route.name)?'profile':'home');
  screen.scrollTop=keepScroll?previousScroll:0;
  if(route.name==='card') startCardAnimation();
  const carousel=document.querySelector('.hero-carousel');
  if(carousel) carousel.addEventListener('scroll',()=>{document.querySelectorAll('.dot').forEach((dot,index)=>dot.classList.toggle('selected',index===Math.round(carousel.scrollLeft/carousel.clientWidth)));});
}
function go(next,reset=false) {
  closeModal();
  if(reset) routeStack=[]; else routeStack.push({...route,scroll:screen.scrollTop});
  route=next;eventDate=0;render();
}
window.appBack=function() {
  if(modal){closeModal();return true;}
  if(route.name==='card'){go({name:'home'},true);return true;}
  if(routeStack.length){const previous=routeStack.pop();route=previous;render();screen.scrollTop=previous.scroll||0;return true;}
  if(route.name!=='home'){go({name:'home'},true);return true;}
  return false;
};
function closeModal() { modal=null;overlay.innerHTML='';if(loadingTimer){clearTimeout(loadingTimer);loadingTimer=null;} }
function showModal(name,value='') {
  modal={name,value};
  if(name==='menu') {
    const categories=[['Böcker & Kurslitteratur','book'],['Mobil & Bredband','phone'],['Kläder & Mode','shirt'],['Skönhet & Hudvård','scissors'],['Resor & Boende','plane'],['TV & Streaming','tv'],['Smycken & Accessoarer','diamond'],['Sport & Träning','ball'],['Hälsa & Apotek','health'],['Inredning & Hushåll','box'],['Matkassar & Livsmedel','food'],['Bank & Försäkring','bank'],['Datorer, Mjukvara & Teknik','laptop'],['Fest, Blommor & Nöje','party']];
    overlay.innerHTML=`<div class="scrim" ${action('dismiss')}><aside class="drawer" role="dialog" aria-label="Kategorier"><h1>Kategorier</h1>${categories.map(([title,symbol])=>`<button class="category" ${action('list',title)}>${icon(symbol)}<span>${title}</span></button>`).join('')}</aside></div>`;
  } else if(name==='coupon') {
    const coupon=D.coupons[value];
    overlay.innerHTML=`<div class="scrim" ${action('dismiss')}><section class="sheet" style="background:${coupon.bgColor}" role="dialog" aria-label="${esc(coupon.brand)}"><div class="close-row">${round('close','Stäng','dismiss')}</div>${picture(coupon,'coupon-logo')}<h2>${esc(coupon.title)}</h2><p>${esc(coupon.description)}</p><hr><p>Denna kupong löper ut. När den har aktiverats förblir den giltig i 4 timmar innan den försvinner.</p><button class="cta" style="--button:#0dc773">ANVÄND KUPONG</button></section></div>`;
  } else if(name==='sort') {
    overlay.innerHTML=`<div class="scrim" ${action('dismiss')}><section class="sheet" role="dialog" aria-label="Sortera"><h2>Sortera</h2>${['Evenemang','Biljettsläpp'].map((text,index)=>`<button class="sort-row" ${action('sort-choice',index)}>${text}<span class="radio ${index===sortChoice?'selected':''}"></span></button>`).join('')}<button class="cta" style="--button:#448aff;margin-top:24px" ${action('dismiss')}>Visa resultat</button></section></div>`;
  } else if(name==='calendar') {
    const days=[...Array.from({length:4},(_,i)=>[27+i,true]),...Array.from({length:31},(_,i)=>[i+1,false])];
    while(days.length%7)days.push([days.length-34,true]);
    overlay.innerHTML=`<div class="scrim" ${action('dismiss')}><section class="sheet" role="dialog" aria-label="Kalender"><div class="calendar-head"><span></span><h2>Kalender</h2><button ${action('clear-day')}>Rensa</button></div><p>Maj 2026</p><div class="calendar-grid">${days.map(([day,dim])=>`<button class="day ${dim?'dim':''} ${!dim&&selectedDay===day?'selected':''}" ${dim?'disabled':action('day',day)}>${day}</button>`).join('')}</div></section></div>`;
  } else if(name==='qr') {
    overlay.innerHTML=`<div class="scrim qr-scrim" ${action('dismiss')}><img class="qr-card" src="${D.assets.qrcard}" alt="QR-kort"></div>`;
  } else if(name==='loading') {
    overlay.innerHTML=`<div class="loading-card" role="status" aria-label="Uppdaterar kort"><img src="${D.assets.loadingcard}" alt="Uppdaterar kort"></div>`;
    loadingTimer=setTimeout(closeModal,2000);
  }
}
function handle(command,value='') {
  switch(command) {
    case 'tab':
      if(value==='card'){cardIndex=1;cardFlipped=false;}
      go({name:value},true);break;
    case 'back':window.appBack();break;
    case 'menu':showModal('menu');break;
    case 'nearby':go({name:'nearby'});break;
    case 'city':go({name:'city',id:Number(value)});break;
    case 'deal':go({name:'deal',id:value});break;
    case 'event':go({name:'event',id:Number(value)});break;
    case 'list':go({name:'list',category:value});break;
    case 'settings':go({name:'settings'});break;
    case 'coupon':showModal('coupon',Number(value));break;
    case 'dismiss':closeModal();break;
    case 'sort':showModal('sort');break;
    case 'sort-choice':sortChoice=Number(value);showModal('sort');break;
    case 'calendar-modal':showModal('calendar');break;
    case 'day':selectedDay=Number(value);showModal('calendar');break;
    case 'clear-day':selectedDay=null;showModal('calendar');break;
    case 'calendar-tab':calendarTab=Number(value);render(true);break;
    case 'event-date':eventDate=Number(value);render(true);break;
    case 'favorite':
      if(favorites.has(value))favorites.delete(value);else favorites.add(value);
      localStorage.setItem('favorites',JSON.stringify([...favorites]));render(true);break;
    case 'flip':cardFlipped=!cardFlipped;document.querySelector('.card-rotator').classList.toggle('flipped',cardFlipped);break;
    case 'card-select':cardIndex=Number(value);render();break;
    case 'close-card':go({name:'home'},true);break;
    case 'qr':showModal('qr');break;
    case 'refresh':showModal('loading');break;
    case 'search':go({name:'list',query:' '});setTimeout(()=>document.querySelector('#list-search')?.focus(),0);break;
    // These actions are empty in the SwiftUI source as well.
    case 'noop':break;
  }
}
document.addEventListener('click',event=>{
  const target=event.target.closest('[data-action]');
  if(!target)return;
  if(target.classList.contains('scrim') && event.target!==target)return;
  handle(target.dataset.action,target.dataset.value);
});
document.addEventListener('keydown',event=>{
  if(event.key==='Escape'){window.appBack();return;}
  if(event.key==='Enter' && ['home-search','list-search'].includes(event.target.id)) {
    const query=event.target.value.trim();
    if(query){event.target.blur();go({name:'list',query});}
  }
});
document.addEventListener('error',event=>{
  if(event.target.tagName==='IMG')event.target.closest('.photo')?.classList.add('failed');
},true);
render();
