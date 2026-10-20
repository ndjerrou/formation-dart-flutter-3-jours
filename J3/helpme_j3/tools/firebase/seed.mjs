import {initializeApp, applicationDefault} from 'firebase-admin/app';
import {getAuth} from 'firebase-admin/auth';
const args=process.argv.slice(2);const emulator=args.includes('--emulator');
const project=args.find(v=>v.startsWith('--project='))?.split('=')[1];
if(!emulator && (!project || project.startsWith('demo-')))throw Error('Fournir --project=IDENTIFIANT_REEL ou --emulator.');
const password=process.env.J3_DEMO_PASSWORD;
if(!password || password.length<12)throw Error('Définir J3_DEMO_PASSWORD (12 caractères minimum).');
if(emulator)process.env.FIREBASE_AUTH_EMULATOR_HOST='127.0.0.1:9099';
initializeApp(emulator?{projectId:'demo-helpme-j3'}:{projectId:project,credential:applicationDefault()});
for(const [email,claims] of [['client.j3@example.test',{role:'client'}],['gerard.j3@example.test',{role:'prestataire',artisanId:1}],['sophie.j3@example.test',{role:'prestataire',artisanId:2}]]){
 let user;try{user=await getAuth().getUserByEmail(email);}catch(e){if(e.code!=='auth/user-not-found')throw e;}
 user=user?await getAuth().updateUser(user.uid,{password}):await getAuth().createUser({email,password});
 await getAuth().setCustomUserClaims(user.uid,claims);console.log(`${email} : ${JSON.stringify(claims)}`);
}
