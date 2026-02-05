import type { RankIssueNumber } from '~~/server/db/schema/ranks/issueNumber';
import type { RankWebInfo } from '~~/server/db/schema/ranks/webInfo';
import type { RankWebBase } from '~~/server/db/schema/ranks/webBase';
import type { RankWebNoList } from '~~/server/db/schema/ranks/webNoList';
import type { RankType } from '~~/server/db/schema/ranks/types';
import { LanguageVo } from '~~/types/language';

type RankWebInfoVo = Pick<RankWebInfo, 'name' | 'subtitle'>;
type RankWebBaseVo = Pick<RankWebBase, 'iconUrl'> & {
  webInfos: RankWebInfoVo[];
};
type RankWebNoListVo = Pick<RankWebNoList, 'mom' | 'rank' | 'visits'> & {
  webBase: RankWebBaseVo;
};

type Data = { rankType: { name: LanguageVo } } & {
  webNoList: RankWebNoListVo[];
};

interface WebListActiveNumberData extends RankIssueNumber {
  number: LanguageVo;
  month: LanguageVo;
}

export interface RanksWebDataUrlKey {
  data: Data;
  webListActiveNumberData: WebListActiveNumberData;
}
