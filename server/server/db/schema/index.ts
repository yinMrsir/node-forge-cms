import * as userSchema from './system/user';
import * as deptSchema from './system/dept';
import * as dictSchema from './system/dict';
import * as menuSchema from './system/menu';
import * as roleSchema from './system/role';
import * as roleToMenuSchema from './system/roleToMenu';
import * as userToRoleSchema from './system/userToRole';
import * as postSchema from './system/post';
import * as userToPostSchema from './system/userToPost';
import * as sysConfigSchema from './system/sysConfig';
import * as navigationConfigSchema from './system/navigationConfig';
import * as loginInfoSchema from './monitor/log/logininfo';
import * as jobSchema from './monitor/job';
import * as jobLogSchema from './monitor/jobLog';
import * as categorySchema from './cms/category';
import * as newsSchema from './cms/news';
import * as productSchema from './cms/product';
import * as contentSchema from './cms/content';
import * as bannerSchema from './cms/banner';
import * as contactSchema from './cms/contact';
import * as seoSchema from './cms/seo';
import * as i18nSchema from './system/i18n';
import * as aiConfigSchema from './system/aiConfig';

export default {
  ...userSchema,
  ...deptSchema,
  ...dictSchema,
  ...menuSchema,
  ...roleSchema,
  ...roleToMenuSchema,
  ...userToRoleSchema,
  ...postSchema,
  ...userToPostSchema,
  ...sysConfigSchema,
  ...navigationConfigSchema,
  ...loginInfoSchema,
  ...jobSchema,
  ...jobLogSchema,
  ...categorySchema,
  ...newsSchema,
  ...productSchema,
  ...contentSchema,
  ...bannerSchema,
  ...contactSchema,
  ...seoSchema,
  ...i18nSchema,
  ...aiConfigSchema
};
