import type { RankIssueNumber } from '~~/server/db/schema/ranks/issueNumber';
import type { RankAppInfo } from '~~/server/db/schema/ranks/appInfo';
import type { RankAppBase } from '~~/server/db/schema/ranks/appBase';
import type { RankAppNoList } from '~~/server/db/schema/ranks/appNoList';
import type { RankType } from '~~/server/db/schema/ranks/types';
import { LanguageVo } from '~~/types/language';

type RankAppInfoVo = Pick<RankAppInfo, 'name' | 'subtitle'>;
type RankAppBaseVo = Pick<RankAppBase, 'iconUrl'> & {
  appInfos: RankAppInfoVo[];
};
type RankAppNoListVo = Pick<RankAppNoList, 'mom' | 'rank' | 'visits'> & {
  appBase: RankAppBaseVo;
};

type Data = { rankType: { name: LanguageVo } } & {
  appNoList: RankAppNoListVo[];
};

interface AppListActiveNumberDataVo extends RankIssueNumber {
  number: LanguageVo;
  month: LanguageVo;
}

export interface RanksAppDataUrlKey {
  data: Data;
  appListActiveNumberData: AppListActiveNumberDataVo;
}
