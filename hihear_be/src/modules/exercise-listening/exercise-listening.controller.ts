import { Body, Controller } from '@nestjs/common';
import { ListeningService } from './exercise-listening.service';
@Controller('listening')
export class ListeningController {
  constructor(private readonly listeningService: ListeningService) {}
}
