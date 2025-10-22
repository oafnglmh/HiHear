import { User } from 'src/modules/users/domains/user';
import { Token } from './token';

export class AuthResult {
  token: Token;

  user: User;
}
