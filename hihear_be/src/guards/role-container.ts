import { applyDecorators, SetMetadata, UseGuards } from '@nestjs/common';
import { RoleType } from './role-type';
import { JwtAuthGuard } from 'src/decorator/jwt-auth-guard';
import { RolesGuard } from './roles.guard';

function requireRole(roles: RoleType[]): MethodDecorator {
  return applyDecorators(
    SetMetadata('roles', roles),
    UseGuards(JwtAuthGuard, RolesGuard),
  );
}

export function RequireAdmin(): MethodDecorator {
  return requireRole([RoleType.ADMIN]);
}

export function RequireLoggedIn(): MethodDecorator {
  return requireRole([RoleType.USER, RoleType.ADMIN]);
}
