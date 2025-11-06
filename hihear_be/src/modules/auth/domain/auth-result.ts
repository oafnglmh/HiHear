import { User } from 'src/modules/users/domains/user';
import { Token } from './token';
import { UserProfile } from 'src/modules/user-profiles/domains/user-profile';

export class AuthResult {
  token: Token;

  user: User;
  profile: UserProfile
}
