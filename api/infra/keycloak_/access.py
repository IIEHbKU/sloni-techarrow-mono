from typing import Dict

from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from keycloak.exceptions import KeycloakAuthenticationError

from infra.keycloak_.client import KeycloakClient
from infra.logger import logger


async def init_keycloak_client() -> None:
    await KeycloakClient.init_client()


async def close_keycloak_client() -> None:
    await KeycloakClient.close_client()


async def authenticate(
        token: HTTPAuthorizationCredentials = Depends(HTTPBearer()),
) -> Dict[str, str]:
    token_value = token.credentials
    try:
        client = KeycloakClient.get_client()
        token_info = client.introspect(token_value)
        print(token_info)
        if not token_info.get("active"):
            raise HTTPException(
                status_code=401,
                detail="Inactive token"
            )
        return {
            "user_id": token_info["sub"],
        }
    except KeycloakAuthenticationError:
        logger.error(f"Invalid token")
        raise HTTPException(
            status_code=401,
            detail="Invalid token"
        )
    except Exception as e:
        raise HTTPException(
            status_code=401,
            detail=f"Invalid token with error [{e}]"
        )
