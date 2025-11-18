import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ListeningEntity } from './entities/listening.entity';

export class ListeningService {
  constructor(
    @InjectRepository(ListeningEntity)
    private readonly listeningRepository: Repository<ListeningEntity>,
  ) {}
}
